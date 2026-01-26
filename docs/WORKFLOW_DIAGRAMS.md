# Workflow Dependency Diagrams

Visual representations of how workflow templates connect and chain together. These Mermaid diagrams render natively on GitHub.

## Table of Contents

- [Release to Publish Chain](#release-to-publish-chain)
- [CI to Deploy Pipeline](#ci-to-deploy-pipeline)
- [Security Scanning Flow](#security-scanning-flow)
- [Project Type Stacks](#project-type-stacks)
  - [Node.js Web Application](#nodejs-web-application)
  - [Python Package](#python-package)
  - [Full-Stack Docker](#full-stack-docker)
  - [Mobile Application](#mobile-application)
  - [Enterprise Stack](#enterprise-stack)
- [Category Overview](#category-overview)

---

## Release to Publish Chain

When `release-please.yml` creates a GitHub Release, it triggers publishing workflows via the `on: release` event.

```mermaid
flowchart TB
    subgraph Trigger["Trigger Event"]
        push["Push to main<br/>(conventional commits)"]
    end

    subgraph Release["Release Management"]
        rp["release-please.yml"]
    end

    subgraph Publishing["Package Registries"]
        npm["publish-npm.yml<br/>npm registry"]
        pypi["publish-pypi.yml<br/>PyPI"]
        crates["publish-crates.yml<br/>crates.io"]
        docker["publish-docker.yml<br/>Docker Hub/GHCR"]
        nuget["publish-nuget.yml<br/>NuGet"]
        maven["publish-maven.yml<br/>Maven Central"]
        rubygems["publish-rubygems.yml<br/>RubyGems"]
    end

    subgraph Observability["Observability"]
        sentry["sentry-release.yml"]
    end

    push --> rp
    rp -->|"on: release"| npm
    rp -->|"on: release"| pypi
    rp -->|"on: release"| crates
    rp -->|"on: release"| docker
    rp -->|"on: release"| nuget
    rp -->|"on: release"| maven
    rp -->|"on: release"| rubygems
    rp -->|"on: release"| sentry

    style rp fill:#4CAF50,color:#fff
    style npm fill:#CB3837,color:#fff
    style pypi fill:#3775A9,color:#fff
    style crates fill:#F46623,color:#fff
    style docker fill:#2496ED,color:#fff
```

### Key Points

- **Trigger**: Push to `main` with conventional commits creates a Release PR
- **Release**: When merged, creates a GitHub Release with tag
- **Publish**: Release event triggers language-specific publish workflows
- **One-to-many**: A single release can trigger multiple publish workflows

---

## CI to Deploy Pipeline

Continuous integration flows into deployment through different stages.

```mermaid
flowchart LR
    subgraph CI["CI Stage"]
        pr["Pull Request"]
        ci["ci-*.yml"]
        security["Security Scans"]
    end

    subgraph Staging["Staging"]
        preview["Preview Deploy"]
        e2e["E2E Tests"]
    end

    subgraph Production["Production"]
        approval["Manual Approval"]
        deploy["Production Deploy"]
    end

    pr --> ci
    ci --> security
    security --> preview
    preview --> e2e
    e2e --> approval
    approval --> deploy

    style ci fill:#2196F3,color:#fff
    style preview fill:#FF9800,color:#fff
    style deploy fill:#4CAF50,color:#fff
```

### Deployment Targets

```mermaid
flowchart TB
    subgraph Source["Source"]
        docker["publish-docker.yml"]
    end

    subgraph Platforms["Deployment Platforms"]
        subgraph PaaS["Platform-as-a-Service"]
            vercel["deploy-vercel.yml"]
            netlify["deploy-netlify.yml"]
            fly["deploy-fly.yml"]
            railway["deploy-railway.yml"]
            render["deploy-render.yml"]
        end

        subgraph Cloud["Cloud Providers"]
            subgraph AWS["AWS"]
                s3["deploy-aws-s3.yml"]
                lambda["deploy-aws-lambda.yml"]
                sam["deploy-sam.yml"]
            end

            subgraph Azure["Azure"]
                webapp["deploy-azure-webapp.yml"]
                functions["deploy-azure-functions.yml"]
                container["deploy-azure-container.yml"]
            end

            subgraph GCP["GCP"]
                cloudrun["deploy-gcp-cloudrun.yml"]
                gcpfunc["deploy-gcp-functions.yml"]
                gke["deploy-gcp-gke.yml"]
            end
        end

        subgraph K8s["Kubernetes"]
            k8s["deploy-kubernetes.yml"]
        end
    end

    docker --> container
    docker --> cloudrun
    docker --> gke
    docker --> k8s

    style vercel fill:#000,color:#fff
    style netlify fill:#00C7B7,color:#fff
    style fly fill:#7B3FE4,color:#fff
```

---

## Security Scanning Flow

Security workflows can run in parallel or sequence depending on configuration.

```mermaid
flowchart TB
    subgraph Triggers["Trigger Events"]
        pr["Pull Request"]
        push["Push to main"]
        schedule["Scheduled (cron)"]
    end

    subgraph SAST["Static Analysis (SAST)"]
        codeql["codeql.yml<br/>Code scanning"]
        snyk_code["snyk.yml<br/>Code analysis"]
        sonar["sonarcloud.yml<br/>Quality gates"]
    end

    subgraph SCA["Dependency Scanning (SCA)"]
        deprev["dependency-review.yml<br/>PR audit"]
        snyk_deps["snyk.yml<br/>Dependency scan"]
        license["license-check.yml<br/>License compliance"]
    end

    subgraph Container["Container Security"]
        trivy["trivy.yml<br/>Image scanning"]
        snyk_container["snyk.yml<br/>Container scan"]
    end

    subgraph IaC["Infrastructure as Code"]
        trivy_iac["trivy.yml<br/>IaC scanning"]
        snyk_iac["snyk.yml<br/>IaC analysis"]
    end

    subgraph DAST["Dynamic Analysis (DAST)"]
        zap["dast-zap.yml<br/>OWASP ZAP"]
    end

    subgraph Compliance["Compliance"]
        scorecard["scorecard.yml<br/>OpenSSF"]
        sbom["sbom.yml<br/>SBOM generation"]
    end

    pr --> deprev
    pr --> codeql
    push --> codeql
    push --> trivy
    schedule --> codeql
    schedule --> snyk_code
    schedule --> zap

    style codeql fill:#24292E,color:#fff
    style trivy fill:#1904DA,color:#fff
    style snyk_code fill:#4C4A73,color:#fff
```

### Security Decision Tree

```mermaid
flowchart TD
    start["Need Security Scanning?"]

    start --> code{"Scan source code?"}
    code -->|Yes| codeql["Use codeql.yml<br/>(free, GitHub-native)"]
    code -->|"Yes + Quality"| sonar["Add sonarcloud.yml"]

    start --> deps{"Scan dependencies?"}
    deps -->|"PR only"| deprev["Use dependency-review.yml"]
    deps -->|"Continuous"| snyk["Use snyk.yml"]

    start --> container{"Scan containers?"}
    container -->|"Open source"| trivy["Use trivy.yml"]
    container -->|"Enterprise"| snyk2["Use snyk.yml"]

    start --> compliance{"Need compliance?"}
    compliance -->|"OpenSSF"| scorecard["Use scorecard.yml"]
    compliance -->|"SBOM"| sbom["Use sbom.yml"]

    style codeql fill:#4CAF50,color:#fff
    style deprev fill:#4CAF50,color:#fff
    style trivy fill:#4CAF50,color:#fff
```

---

## Project Type Stacks

### Node.js Web Application

```mermaid
flowchart TB
    subgraph CI["Continuous Integration"]
        ci["ci-nodejs.yml"]
        lint["commitlint.yml"]
        format["format-check.yml"]
    end

    subgraph Quality["Quality Assurance"]
        e2e["e2e-playwright.yml"]
        lighthouse["lighthouse.yml"]
        a11y["a11y.yml"]
    end

    subgraph Security["Security"]
        codeql["codeql.yml"]
        deprev["dependency-review.yml"]
    end

    subgraph Release["Release"]
        rp["release-please.yml"]
    end

    subgraph Deploy["Deployment"]
        vercel["deploy-vercel.yml"]
    end

    subgraph Publish["Publishing"]
        npm["publish-npm.yml"]
    end

    ci --> e2e
    ci --> codeql
    e2e --> vercel
    rp --> npm

    style ci fill:#339933,color:#fff
    style vercel fill:#000,color:#fff
    style npm fill:#CB3837,color:#fff
```

**Copy command:**
```bash
cp templates/workflows/{ci-nodejs,commitlint,e2e-playwright,codeql,dependency-review,release-please,deploy-vercel}.yml .github/workflows/
```

---

### Python Package

```mermaid
flowchart TB
    subgraph CI["Continuous Integration"]
        ci["ci-python.yml"]
        lint["commitlint.yml"]
    end

    subgraph Quality["Quality"]
        coverage["codecov.yml"]
        sonar["sonarcloud.yml"]
    end

    subgraph Security["Security"]
        codeql["codeql.yml"]
        deprev["dependency-review.yml"]
    end

    subgraph Release["Release"]
        rp["release-please.yml"]
    end

    subgraph Publish["Publishing"]
        pypi["publish-pypi.yml"]
    end

    ci --> coverage
    ci --> codeql
    rp --> pypi

    style ci fill:#3776AB,color:#fff
    style pypi fill:#3775A9,color:#fff
```

**Copy command:**
```bash
cp templates/workflows/{ci-python,commitlint,codecov,codeql,dependency-review,release-please,publish-pypi}.yml .github/workflows/
```

---

### Full-Stack Docker

```mermaid
flowchart TB
    subgraph CI["Continuous Integration"]
        ci["ci-nodejs.yml"]
        e2e["e2e-playwright.yml"]
    end

    subgraph Security["Security"]
        codeql["codeql.yml"]
        trivy["trivy.yml"]
    end

    subgraph Release["Release"]
        rp["release-please.yml"]
    end

    subgraph Publish["Publishing"]
        docker["publish-docker.yml"]
    end

    subgraph Deploy["Deployment"]
        k8s["deploy-kubernetes.yml"]
    end

    subgraph Notify["Notifications"]
        slack["notify-slack.yml"]
    end

    ci --> e2e
    ci --> codeql
    rp --> docker
    docker --> trivy
    docker --> k8s
    k8s --> slack

    style ci fill:#339933,color:#fff
    style docker fill:#2496ED,color:#fff
    style k8s fill:#326CE5,color:#fff
```

**Copy command:**
```bash
cp templates/workflows/{ci-nodejs,e2e-playwright,codeql,trivy,release-please,publish-docker,deploy-kubernetes,notify-slack}.yml .github/workflows/
```

---

### Mobile Application

```mermaid
flowchart TB
    subgraph CI["Continuous Integration"]
        android["ci-android.yml"]
        ios["ci-ios.yml"]
        flutter["ci-flutter.yml"]
    end

    subgraph Security["Security"]
        codeql["codeql.yml"]
        deprev["dependency-review.yml"]
    end

    subgraph Release["Release"]
        rp["release-please.yml"]
    end

    subgraph Publish["Publishing"]
        playstore["publish-play-store.yml"]
        testflight["publish-testflight.yml"]
    end

    android --> codeql
    ios --> codeql
    flutter --> android
    flutter --> ios
    rp --> playstore
    rp --> testflight

    style android fill:#3DDC84,color:#000
    style ios fill:#000,color:#fff
    style playstore fill:#414141,color:#fff
    style testflight fill:#0D96F6,color:#fff
```

**Copy command (Flutter):**
```bash
cp templates/workflows/{ci-flutter,codeql,dependency-review,release-please,publish-play-store,publish-testflight}.yml .github/workflows/
```

---

### Enterprise Stack

```mermaid
flowchart TB
    subgraph CI["Continuous Integration"]
        ci["ci-java.yml"]
        format["format-check.yml"]
    end

    subgraph Quality["Quality Gates"]
        sonar["sonarcloud.yml"]
        coverage["codecov.yml"]
        contract["contract-pact.yml"]
    end

    subgraph Security["Security Suite"]
        codeql["codeql.yml"]
        snyk["snyk.yml"]
        scorecard["scorecard.yml"]
        sbom["sbom.yml"]
    end

    subgraph Release["Release Management"]
        rp["release-please.yml"]
    end

    subgraph Publish["Artifact Publishing"]
        maven["publish-maven.yml"]
        docker["publish-docker.yml"]
    end

    subgraph Deploy["Multi-Environment"]
        multi["deploy-multi-env.yml"]
        k8s["deploy-kubernetes.yml"]
    end

    subgraph Observe["Observability"]
        datadog["datadog-ci.yml"]
        sentry["sentry-release.yml"]
    end

    subgraph Notify["Notifications"]
        slack["notify-slack.yml"]
        teams["notify-teams.yml"]
    end

    ci --> sonar
    ci --> codeql
    ci --> snyk
    rp --> maven
    rp --> docker
    docker --> multi
    multi --> k8s
    k8s --> datadog
    rp --> sentry
    k8s --> slack

    style ci fill:#007396,color:#fff
    style sonar fill:#4E9BCD,color:#fff
    style snyk fill:#4C4A73,color:#fff
    style k8s fill:#326CE5,color:#fff
```

---

## Category Overview

High-level view of all workflow categories and their relationships.

```mermaid
flowchart LR
    subgraph Input["Development"]
        code["Code Changes"]
    end

    subgraph CI["CI/Testing"]
        ci["Build & Test"]
        e2e["E2E Tests"]
        quality["Quality Checks"]
    end

    subgraph Security["Security"]
        scan["Security Scans"]
    end

    subgraph Release["Release"]
        release["Release Management"]
    end

    subgraph Publish["Publishing"]
        packages["Package Registries"]
        containers["Container Registries"]
    end

    subgraph Deploy["Deployment"]
        paas["PaaS Platforms"]
        cloud["Cloud Providers"]
        k8s["Kubernetes"]
    end

    subgraph Observe["Observability"]
        monitor["Monitoring"]
    end

    subgraph Notify["Notifications"]
        alerts["Alerts & Notifications"]
    end

    code --> ci
    ci --> e2e
    ci --> quality
    ci --> scan
    quality --> release
    scan --> release
    release --> packages
    release --> containers
    containers --> paas
    containers --> cloud
    containers --> k8s
    k8s --> monitor
    release --> monitor
    monitor --> alerts
    k8s --> alerts

    style ci fill:#2196F3,color:#fff
    style scan fill:#F44336,color:#fff
    style release fill:#4CAF50,color:#fff
    style k8s fill:#326CE5,color:#fff
```

---

## Workflow Trigger Types

Understanding when workflows run based on their trigger configuration.

```mermaid
flowchart TB
    subgraph push["on: push"]
        ci["CI workflows"]
        release_please["release-please"]
        deploy_prod["Production deploys"]
    end

    subgraph pr["on: pull_request"]
        ci_pr["CI workflows"]
        deprev["dependency-review"]
        preview["Preview deploys"]
    end

    subgraph release["on: release"]
        publish["Publish workflows"]
        sentry["sentry-release"]
    end

    subgraph schedule["on: schedule"]
        security["Security scans"]
        stale["stale bot"]
        link["link-checker"]
    end

    subgraph dispatch["on: workflow_dispatch"]
        manual["Manual releases"]
        deploy_manual["Manual deploys"]
    end

    subgraph call["on: workflow_call"]
        reusable["Reusable workflows"]
        notify["Notifications"]
    end

    style push fill:#4CAF50,color:#fff
    style pr fill:#2196F3,color:#fff
    style release fill:#9C27B0,color:#fff
    style schedule fill:#FF9800,color:#fff
    style dispatch fill:#607D8B,color:#fff
    style call fill:#795548,color:#fff
```

---

## See Also

- [Workflow Metadata Index](../templates/workflows/workflow-metadata.yaml) - Structured data for all workflows
- [Compatibility Matrix](COMPATIBILITY_MATRIX.md) - Preset compatibility documentation
- [Workflow README](../templates/workflows/README.md) - Quick reference tables
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
