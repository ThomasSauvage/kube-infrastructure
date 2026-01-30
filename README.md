# BRoT: BR over Télécom

## Usage

### Prerequisites

- Install [Brew](https://brew.sh/)

```sh
brew install kubectl helm git-crypt argocd cilium-cli siderolabs/tap/talosctl
```

- Merge this cluster's kubeconfig to your local kubeconfig. This should not delete any existing contexts, but to be safe, this command first creates a backup of your existing kubeconfig.

```sh
cp ~/.kube/config ~/.kube/config.bkp
KUBECONFIG=~/.kube/config:$(pwd)/kubeconfig.secrets.yml kubectl config view --flatten > ~/.kube/config_merged
mv ~/.kube/config_merged ~/.kube/config
```

### Accessing the cluster

```sh
kubectl config use-context admin@kube-brot

kubectl get pods -A
```

## Cluster features

- Kubernetes VMs over Proxmox with [Talos](https://www.talos.dev/)
- Container Network Interface (CNI) with [Cilium](https://cilium.io/)
- Fully dual-stack (IPv4 and IPv6) cluster
- GitOps with [ArgoCD](https://argo-cd.readthedocs.io/)
- Load balancer L2 advertisement with [Cilium](https://docs.cilium.io/en/latest/network/l2-announcements/)
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

## Creating the cluster

cf. [Talos-over-Proxmox configuration](./COOKBOOK.md)

- First, setup the cluster VMs with Talos. See [talos/COOKBOOK.md](talos/COOKBOOK.md).
- Then, bootstrap the cluster. See [bootstrap/COOKBOOK.md](bootstrap/COOKBOOK.md)
- Apps in `apps/` should now be deployed.

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

## Debugging and pen-testing

- A pod to try to `curl`. An other interesting tool is `busybox:1.28`.

```sh
kubectl run curler --image=curlimages/curl:latest --restart=Never -- sleep 1d

kubectl exec -it curler -- ping 1.1.1.1

kubectl delete pod curler
```
