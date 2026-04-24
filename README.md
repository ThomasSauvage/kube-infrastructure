# Kube infrastructure

This repository contains the configuration of a Kubernetes cluster.

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
- Network policies with [Cilium Network Policies](https://docs.cilium.io/en/stable/security/policy/)
- Cilium's [Hubble](https://docs.cilium.io/en/stable/observability/hubble/) for network observability, useful for network policy troubleshooting
  - [Basic auth](https://gateway.envoyproxy.io/docs/tasks/security/basic-auth) to secure the access to Hubble UI
- Certificate management with [Cert manager](https://cert-manager.io/)
- Certificate autorenewal using OVH DNS challenges with [Cert manager webhook OVH](https://aureq.github.io/cert-manager-webhook-ovh/)
- Secret storage with [Git crypt](https://github.com/AGWA/git-crypt)
- Deployments
  - [Google online boutique](https://github.com/GoogleCloudPlatform/microservices-demo)
  - [whoami](https://github.com/traefik/whoami)
  - [BRoT app](https://github.com/ThomasSauvage/brot-app) with a CI/CD pipeline building and pushing container images to GHCR
- Automatic image rollout for the BRoT app on the Github Actions CI/CD

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

## Creating the cluster

cf. [Talos-over-Proxmox configuration](./COOKBOOK.md)

- First, setup the cluster VMs with Talos. See [talos/COOKBOOK.md](talos/COOKBOOK.md).
- Then, bootstrap the cluster. See [bootstrap/COOKBOOK.md](bootstrap/COOKBOOK.md)
- Apps in `apps/` should now be deployed.

## Debugging and pen-testing

- A pod to try to `curl`. An other interesting tool is `busybox:1.28`.

```sh
kubectl run curler --image=curlimages/curl:latest --restart=Never -- sleep 1d

kubectl exec -it curler -- ping 1.1.1.1

kubectl delete pod curler
```

- You can, for exemple, try security labels on the `curler` pod (it can take around 30s to be effective):

```sh
kubectl label pod curler security-gateway-accessible=true
```
