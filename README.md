# BRoT: BR over Télécom

## Installation

cf. [Talos-over-Proxmox configuration](./COOKBOOK.md)

- First, setup the cluster VMs with Talos. See [talos/COOKBOOK.md](talos/COOKBOOK.md).
- Then, bootstrap the cluster. See [bootstrap/COOKBOOK.md](bootstrap/COOKBOOK.md)
- Apps in `apps/` should now be deployed.

## Install CLIs

- Install [Brew](https://brew.sh/)

```sh
brew install kubectl helm git-crypt argocd cilium-cli siderolabs/tap/talosctl
```

## Usage

```sh
export KUBECONFIG=$(pwd)/kubeconfig.secrets.yml
kubectl get nodes
```

## Cluster features

- Kubernetes VMs over Proxmox with [Talos](https://www.talos.dev/)
- GitOps with [ArgoCD](https://argo-cd.readthedocs.io/)
- Load balancer L2 advertisement with [MetalLB](https://metallb.io/)
- Gateway API with [Envoy Gateway](https://gateway.envoyproxy.io/)
  - HTTPS support
  - HTTP to HTTPS redirection support
  - HTTP3 / QUIC support
- Certificate management with [Cert manager](https://cert-manager.io/)
- Certificate autorenewal using OVH DNS challenges with [Cert manager webhook OVH](https://aureq.github.io/cert-manager-webhook-ovh/)
- Secret storage with [Git crypt](https://github.com/AGWA/git-crypt)
- Deployments
  - [Google online boutique](https://github.com/GoogleCloudPlatform/microservices-demo)
  - [whoami](https://github.com/traefik/whoami)

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
