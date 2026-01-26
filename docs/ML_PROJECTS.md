# ML/AI Project Setup Guide

This guide covers GitHub Actions setup for machine learning and AI projects, including GPU workflows, model versioning, and experiment tracking integration.

## Quick Start

```bash
/github-setup ml
```

This installs:

- `ci-ml-python.yml` - ML-optimized CI workflow
- Dependabot configuration
- Editor configuration

## Workflow Features

### Standard CI Pipeline

The ML workflow includes:

| Feature | Description |
|---------|-------------|
| **Linting** | ruff, mypy for code quality |
| **Notebook validation** | nbqa, nbstripout for Jupyter notebooks |
| **Testing** | pytest with coverage across Python versions |
| **DVC integration** | Data and model versioning |

### GPU Support

For GPU-accelerated testing and training, you have two options:

#### Option 1: Self-Hosted Runners

Add a self-hosted runner with GPU access:

```yaml
jobs:
  gpu-test:
    runs-on: [self-hosted, gpu]
    steps:
      - uses: actions/checkout@v4
      - name: Check GPU
        run: nvidia-smi
      - name: Run GPU tests
        run: pytest -m gpu
```

Setup requirements:

1. Install GitHub Actions runner on GPU machine
2. Add labels: `self-hosted`, `gpu`
3. Ensure CUDA drivers are installed

#### Option 2: GitHub Larger Runners

For GitHub Enterprise or Teams, use GPU-enabled larger runners:

```yaml
jobs:
  gpu-test:
    runs-on: ubuntu-gpu-large  # GPU-enabled runner
```

See [GitHub documentation](https://docs.github.com/en/actions/using-github-hosted-runners/about-larger-runners) for available GPU runners.

## Data Version Control (DVC)

### Setup DVC

1. Initialize DVC in your project:

   ```bash
   pip install dvc
   dvc init
   ```

2. Configure a remote storage:

   ```bash
   # S3
   dvc remote add -d myremote s3://my-bucket/dvc

   # Google Cloud Storage
   dvc remote add -d myremote gs://my-bucket/dvc

   # Azure Blob Storage
   dvc remote add -d myremote azure://my-container/dvc
   ```

3. Add data files to DVC:

   ```bash
   dvc add data/dataset.csv
   git add data/dataset.csv.dvc data/.gitignore
   ```

### DVC in CI

The workflow automatically:

1. Pulls tracked data from remote storage
2. Reproduces the DVC pipeline (`dvc repro`)
3. Reports pipeline status

Configure secrets for remote access:

| Remote | Required Secrets |
|--------|------------------|
| S3 | `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` |
| GCS | `GOOGLE_APPLICATION_CREDENTIALS` (JSON content) |
| Azure | `AZURE_STORAGE_CONNECTION_STRING` |

Example workflow configuration:

```yaml
- name: Configure DVC remote
  run: |
    dvc remote modify myremote --local access_key_id ${{ secrets.AWS_ACCESS_KEY_ID }}
    dvc remote modify myremote --local secret_access_key ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

## Experiment Tracking

### Weights & Biases

1. Add secret: `WANDB_API_KEY`

2. Configure in workflow:

   ```yaml
   - name: Configure W&B
     env:
       WANDB_API_KEY: ${{ secrets.WANDB_API_KEY }}
     run: wandb login --relogin
   ```

3. Use in training:

   ```python
   import wandb

   wandb.init(project="my-project")
   wandb.log({"loss": loss, "accuracy": accuracy})
   ```

### MLflow

1. Add secrets:
   - `MLFLOW_TRACKING_URI`
   - `MLFLOW_TRACKING_USERNAME` (optional)
   - `MLFLOW_TRACKING_PASSWORD` (optional)

2. Configure in workflow:

   ```yaml
   - name: Configure MLflow
     env:
       MLFLOW_TRACKING_URI: ${{ secrets.MLFLOW_TRACKING_URI }}
     run: echo "MLflow configured"
   ```

3. Use in training:

   ```python
   import mlflow

   mlflow.set_experiment("my-experiment")
   with mlflow.start_run():
       mlflow.log_param("learning_rate", 0.01)
       mlflow.log_metric("accuracy", 0.95)
       mlflow.sklearn.log_model(model, "model")
   ```

## Jupyter Notebook Best Practices

### Notebook Validation

The workflow validates notebooks by:

1. **Format checking** with nbqa + ruff
2. **Structure validation** with nbconvert
3. **Output stripping** verification with nbstripout

### Pre-commit Hooks for Notebooks

Add to `.pre-commit-config.yaml`:

```yaml
repos:
  - repo: https://github.com/kynan/nbstripout
    rev: 0.6.1
    hooks:
      - id: nbstripout

  - repo: https://github.com/nbQA-dev/nbQA
    rev: 1.7.1
    hooks:
      - id: nbqa-ruff
```

### Notebook Testing with papermill

For parameterized notebook testing:

```yaml
- name: Run notebook tests
  run: |
    pip install papermill
    papermill notebooks/train.ipynb output.ipynb -p epochs 1
```

## Model Artifacts

### Storing Models

For small models (<100MB), use GitHub Artifacts:

```yaml
- name: Upload model
  uses: actions/upload-artifact@v4
  with:
    name: trained-model
    path: models/model.pkl
    retention-days: 30
```

For larger models, use external storage:

```yaml
- name: Upload to S3
  run: |
    aws s3 cp models/model.pt s3://my-bucket/models/${{ github.sha }}/
```

### Model Registry Integration

#### Hugging Face Hub

```yaml
- name: Push to Hugging Face
  env:
    HF_TOKEN: ${{ secrets.HF_TOKEN }}
  run: |
    huggingface-cli login --token $HF_TOKEN
    python -c "
    from transformers import AutoModel
    model = AutoModel.from_pretrained('./model')
    model.push_to_hub('my-org/my-model')
    "
```

#### MLflow Model Registry

```yaml
- name: Register model
  run: |
    mlflow models register -m runs:/$RUN_ID/model --name my-model
```

## Testing ML Code

### Test Categories

Structure tests by resource requirements:

```python
# tests/test_model.py
import pytest

def test_data_loading():
    """Fast, CPU-only test"""
    ...

@pytest.mark.slow
def test_training_convergence():
    """Slower test, still CPU"""
    ...

@pytest.mark.gpu
def test_gpu_training():
    """Requires GPU"""
    ...
```

### Running Tests

```bash
# Fast tests only
pytest -m "not slow and not gpu"

# All CPU tests
pytest -m "not gpu"

# GPU tests only
pytest -m gpu
```

### Hypothesis for ML Testing

Use property-based testing for data processing:

```python
from hypothesis import given, strategies as st
import numpy as np

@given(st.lists(st.floats(allow_nan=False), min_size=1))
def test_normalization(data):
    arr = np.array(data)
    normalized = (arr - arr.mean()) / arr.std()
    assert np.isclose(normalized.mean(), 0, atol=1e-10)
```

## Security Considerations

### Secrets Management

Never commit:

- API keys
- Model weights (if proprietary)
- Training data
- Credentials

Use GitHub Secrets for sensitive values:

```bash
gh secret set WANDB_API_KEY
gh secret set AWS_ACCESS_KEY_ID
gh secret set AWS_SECRET_ACCESS_KEY
```

### Data Privacy

For sensitive data:

1. Use private DVC remotes with access controls
2. Implement data anonymization in preprocessing
3. Consider differential privacy in training

## Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| OOM during training | Reduce batch size, use gradient checkpointing |
| DVC pull fails | Check remote credentials, storage permissions |
| Notebook validation fails | Clear outputs with `nbstripout` |
| GPU not detected | Verify CUDA installation, driver compatibility |

### Debug Mode

Enable verbose logging:

```yaml
- name: Debug training
  env:
    PYTHONUNBUFFERED: 1
    WANDB_DEBUG: true
  run: python train.py --verbose
```

## Related Documentation

- [Database Testing](./DATABASE_TESTING.md) - For ML pipelines with databases
- [Secrets Management](./SECRETS_MANAGEMENT.md) - Secure credential handling
- [Renovate vs Dependabot](./RENOVATE_VS_DEPENDABOT.md) - ML dependency management
