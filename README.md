# BRoT: BR over Télécom

## Installation

cf. [Talos-over-Proxmox configuration](./COOKBOOK.md)

## Usage

```sh
export KUBECONFIG=$(pwd)/kubeconfig.secrets.yml
kubectl get nodes
```

## Ideas of things to do

- SAST

  - SonarQube: https://github.com/SonarSource/sonarqube
  - Semgrep: https://github.com/semgrep/semgrep
  - Bearer: https://github.com/Bearer/bearer
  - Horusec: https://github.com/ZupIT/horusec
  - Code QL (integrated in github)
  - Bandit (python), Bearer(javascript,…), Mate (c/c++), blackslash, …

- Secret detection

  - Gitleaks
  - TruffleHog

- SCA & Image Vulnerability Scanner

  - Trivy: https://trivy.dev/ (includes also posture management)
  - Grype: https://github.com/anchore/grype (vulnerability for containers)
  - Syft: https://github.com/anchore/syft (SBOM for containers)
  - VMClarity: https://github.com/openclarity/vmclarity (for VMs)
  - See also: https://owasp.org/www-community/Free_for_Open_Source_Application_Security_Tools

- Cloud Security Posture Management

  - Trivy (IaC, terraform, K8s)
  - Kubescore, Kubescape (K8s)

- Dynamic application security testing

  - Zed Attack Proxy (web app). https://www.zaproxy.org
  - Nikto
  - Many others…
  - (See https://github.com/paulveillard/cybersecurity-dast?tab=readme-
    ov-file)

- Telemetry

  - Collectors : Prometheus, Cilium, Tetragon, … or offered as a service by cloud providers
  - Standard format (OpenTelemetry)
