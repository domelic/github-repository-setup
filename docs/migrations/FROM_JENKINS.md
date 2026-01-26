# Migrating from Jenkins to GitHub Actions

This guide helps you migrate your CI/CD pipelines from Jenkins to GitHub Actions.

## Quick Comparison

| Concept | Jenkins | GitHub Actions |
|---------|---------|----------------|
| Config file | `Jenkinsfile` | `.github/workflows/*.yml` |
| Pipeline syntax | Declarative/Scripted Groovy | YAML |
| Agents | `agent { label 'node' }` | `runs-on: ubuntu-latest` |
| Stages | `stages { stage('Build') {} }` | `jobs:` |
| Steps | `steps { sh 'cmd' }` | `steps:` with `run:` |
| Plugins | Jenkins plugins | Actions from Marketplace |
| Secrets | Credentials plugin | GitHub Secrets |
| Shared libraries | Shared libraries | Reusable workflows |

## Basic Conversion

### Jenkins Declarative Pipeline

```groovy
// Jenkinsfile
pipeline {
    agent any

    environment {
        NODE_ENV = 'production'
        DEPLOY_TOKEN = credentials('deploy-token')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install') {
            steps {
                sh 'npm ci'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test'
            }
            post {
                always {
                    junit 'test-results/*.xml'
                }
            }
        }

        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }

        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                sh 'npm run deploy'
            }
        }
    }

    post {
        success {
            slackSend channel: '#builds', message: 'Build succeeded!'
        }
        failure {
            slackSend channel: '#builds', message: 'Build failed!'
        }
    }
}
```

### GitHub Actions Equivalent

```yaml
# .github/workflows/ci.yml
name: CI/CD

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

env:
  NODE_ENV: production

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install
        run: npm ci

      - name: Test
        run: npm test

      - name: Upload test results
        if: always()
        uses: dorny/test-reporter@v1
        with:
          name: Test Results
          path: test-results/*.xml
          reporter: java-junit

      - name: Build
        run: npm run build

  deploy:
    needs: build-and-test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main' && github.event_name == 'push'
    steps:
      - uses: actions/checkout@v4

      - name: Deploy
        run: npm run deploy
        env:
          DEPLOY_TOKEN: ${{ secrets.DEPLOY_TOKEN }}

      - name: Notify Slack (success)
        if: success()
        uses: slackapi/slack-github-action@v1.27.0
        with:
          channel-id: 'builds'
          slack-message: 'Build succeeded!'
        env:
          SLACK_BOT_TOKEN: ${{ secrets.SLACK_BOT_TOKEN }}

      - name: Notify Slack (failure)
        if: failure()
        uses: slackapi/slack-github-action@v1.27.0
        with:
          channel-id: 'builds'
          slack-message: 'Build failed!'
        env:
          SLACK_BOT_TOKEN: ${{ secrets.SLACK_BOT_TOKEN }}
```

## Concept Mapping

### Agents to Runners

**Jenkins:**
```groovy
agent {
    label 'linux && docker'
}

// Or Docker agent
agent {
    docker {
        image 'node:20'
        args '-v /var/run/docker.sock:/var/run/docker.sock'
    }
}
```

**GitHub Actions:**
```yaml
# Standard runner
runs-on: ubuntu-latest

# Or with container
runs-on: ubuntu-latest
container:
  image: node:20
  options: --user root

# Or self-hosted
runs-on: self-hosted
```

### Stages to Jobs

**Jenkins:**
```groovy
stages {
    stage('Build') {
        steps { sh 'make build' }
    }
    stage('Test') {
        steps { sh 'make test' }
    }
    stage('Deploy') {
        steps { sh 'make deploy' }
    }
}
```

**GitHub Actions:**
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: make build

  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - run: make test

  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - run: make deploy
```

### Parallel Stages

**Jenkins:**
```groovy
stage('Test') {
    parallel {
        stage('Unit Tests') {
            steps { sh 'npm run test:unit' }
        }
        stage('Integration Tests') {
            steps { sh 'npm run test:integration' }
        }
    }
}
```

**GitHub Actions:**
```yaml
# Jobs run in parallel by default
unit-tests:
  runs-on: ubuntu-latest
  steps:
    - run: npm run test:unit

integration-tests:
  runs-on: ubuntu-latest
  steps:
    - run: npm run test:integration
```

### Credentials to Secrets

**Jenkins:**
```groovy
environment {
    AWS_ACCESS_KEY = credentials('aws-access-key')
    GIT_CREDS = credentials('github-token')
}

steps {
    withCredentials([usernamePassword(
        credentialsId: 'docker-hub',
        usernameVariable: 'DOCKER_USER',
        passwordVariable: 'DOCKER_PASS'
    )]) {
        sh 'docker login -u $DOCKER_USER -p $DOCKER_PASS'
    }
}
```

**GitHub Actions:**
```yaml
env:
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}

steps:
  - name: Login to Docker Hub
    uses: docker/login-action@v3
    with:
      username: ${{ secrets.DOCKER_USER }}
      password: ${{ secrets.DOCKER_PASS }}
```

### Parameters to Inputs

**Jenkins:**
```groovy
parameters {
    string(name: 'ENVIRONMENT', defaultValue: 'staging')
    choice(name: 'ACTION', choices: ['deploy', 'rollback'])
    booleanParam(name: 'DRY_RUN', defaultValue: false)
}
```

**GitHub Actions:**
```yaml
on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Environment'
        required: true
        default: 'staging'
        type: choice
        options:
          - staging
          - production
      action:
        description: 'Action'
        required: true
        type: choice
        options:
          - deploy
          - rollback
      dry-run:
        description: 'Dry run'
        type: boolean
        default: false
```

### Post Actions

**Jenkins:**
```groovy
post {
    always {
        cleanWs()
        junit 'test-results/**/*.xml'
    }
    success {
        archiveArtifacts artifacts: 'build/**'
    }
    failure {
        mail to: 'team@example.com', subject: 'Build Failed'
    }
    cleanup {
        sh 'docker system prune -f'
    }
}
```

**GitHub Actions:**
```yaml
steps:
  - name: Run tests
    run: npm test

  - name: Upload test results
    if: always()
    uses: actions/upload-artifact@v4
    with:
      name: test-results
      path: test-results/**/*.xml

  - name: Upload build artifacts
    if: success()
    uses: actions/upload-artifact@v4
    with:
      name: build
      path: build/**

  - name: Send failure notification
    if: failure()
    run: |
      # Send email or Slack notification

  - name: Cleanup
    if: always()
    run: docker system prune -f
```

### Shared Libraries

**Jenkins:**
```groovy
// In Jenkinsfile
@Library('my-shared-library') _

mySharedPipeline()
```

**GitHub Actions:**
```yaml
# Reusable workflow
jobs:
  build:
    uses: org/shared-workflows/.github/workflows/build.yml@main
    with:
      node-version: '20'
    secrets: inherit
```

### Matrix Builds

**Jenkins:**
```groovy
matrix {
    axes {
        axis {
            name 'NODE_VERSION'
            values '18', '20'
        }
        axis {
            name 'OS'
            values 'linux', 'windows'
        }
    }
    stages {
        stage('Test') {
            steps { sh 'npm test' }
        }
    }
}
```

**GitHub Actions:**
```yaml
jobs:
  test:
    strategy:
      matrix:
        node-version: ['18', '20']
        os: [ubuntu-latest, windows-latest]
    runs-on: ${{ matrix.os }}
    steps:
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm test
```

### Triggers

**Jenkins:**
```groovy
triggers {
    cron('0 0 * * *')
    pollSCM('H/15 * * * *')
    upstream(upstreamProjects: 'other-job', threshold: hudson.model.Result.SUCCESS)
}
```

**GitHub Actions:**
```yaml
on:
  schedule:
    - cron: '0 0 * * *'
  push:
    branches: [main]
  workflow_run:
    workflows: ["Other Workflow"]
    types: [completed]
```

## Plugin to Action Mapping

| Jenkins Plugin | GitHub Action |
|---------------|---------------|
| Git | Built-in `actions/checkout` |
| NodeJS | `actions/setup-node` |
| Docker Pipeline | `docker/build-push-action` |
| Slack Notification | `slackapi/slack-github-action` |
| JUnit | `dorny/test-reporter` |
| SonarQube | `SonarSource/sonarcloud-github-action` |
| AWS CLI | `aws-actions/configure-aws-credentials` |
| Kubernetes | `azure/k8s-deploy` |
| Artifactory | `jfrog/setup-jfrog-cli` |

## Migration Checklist

- [ ] Create `.github/workflows/` directory
- [ ] Convert `Jenkinsfile` to GitHub Actions workflow(s)
- [ ] Migrate Jenkins credentials to GitHub Secrets
- [ ] Replace Jenkins plugins with GitHub Actions
- [ ] Convert shared libraries to reusable workflows
- [ ] Set up self-hosted runners if needed
- [ ] Configure branch protection rules
- [ ] Migrate parameterized builds to `workflow_dispatch`
- [ ] Update webhooks and integrations
- [ ] Test workflow on a branch before merging
- [ ] Update documentation and README
- [ ] Decommission Jenkins jobs after validation

## Common Gotchas

1. **Groovy to YAML**: No scripting in YAML; use shell scripts or composite actions
2. **Checkout**: Always add `actions/checkout@v4` explicitly
3. **Workspace**: Each job starts fresh; use artifacts to share data
4. **Agent labels**: Map to GitHub-hosted or self-hosted runners
5. **Blue Ocean**: Use GitHub Actions UI or third-party tools

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Migrating from Jenkins](https://docs.github.com/en/actions/migrating-to-github-actions/migrating-from-jenkins-to-github-actions)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)
