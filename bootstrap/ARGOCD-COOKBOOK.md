# Initial ArgoCD setup on Kubernetes

## Setup

```sh
./argocd.apply.sh

# on another terminal session
kubectl port-forward svc/argocd-server -n argocd 9080:443

# back to first terminal session
brew install argocd

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
