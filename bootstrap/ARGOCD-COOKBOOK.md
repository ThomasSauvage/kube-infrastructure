# Initial ArgoCD setup on Kubernetes

## Setup

```sh
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# on another terminal session
kubectl port-forward svc/argocd-server -n argocd 9080:443

# back to first terminal session
argocd admin initial-password -n argocd
argocd login localhost:9080
#  <y> (insecure)
#  <initial password>
#  <new password>
#  <confirm new password>
argocd account update-password
```

## Create Github fine-grained personal access token

cf. https://github.com/settings/personal-access-tokens/new

Options:
- Expiration: No expiration
- Select scopes: ThomasSauvage/br-over-telecom
- Permissions: Contents: Read access

## Bootstrap Application

1. Connect to the ArgoCD UI: https://localhost:9080 (insecure)
2. Settings -> Repositories
3. Connect Repo **via HTTPS**
  - Project: `default`
  - Repository URL: `https://github.com/ThomasSauvage/br-over-telecom`
  - Username: `ThomasSauvage`
  - Password: `<personal access token created above>`

```sh
kubectl apply -f argocd-bootstrap.yml
```
