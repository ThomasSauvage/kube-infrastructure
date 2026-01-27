# Bootstraping the cluster

The bootstrapping allows to install the base components of the cluster.

## Bootstraping Cilium

- Install cilium cli on your computer

```sh
brew install cilium-cli
```

- Install Cilium on the cluster

```sh
./cilium.helm.sh
```

## Bootstraping ArgoCD

```sh
./argocd.apply.sh

# on another terminal session
kubectl port-forward svc/argocd-server -n argocd 9080:443

# back to first terminal session
brew install argocd

argocd admin initial-password -n argocd
argocd login localhost:9080
# username: admin
# password: <initial password>
#  <y> (insecure)

argocd account update-password
#  <initial password>
#  <new password>
#  <confirm new password>
```

### Create a Github fine-grained personal access token

cf. https://github.com/settings/personal-access-tokens/new

Options:

- Expiration: No expiration
- Select scopes: ThomasSauvage/br-over-telecom
- Permissions: Contents: Read access

## Applying secrets

Secrets are managed outside of ArgoCD, and applied manually using the following command:

```sh
kubectl apply -f "*.secrets.yml"
```

### OVH secret generation

- We use Let's encrypt and OVH certificate DNS01 challenges

- To generate the OVH secrets:
  - Connect to ovh.com
  - Create a secret at: [ovh.com/...](https://www.ovh.com/auth/api/createToken?GET=/domain/zone/&GET=/domain/zone/epy.ovh/*&PUT=/domain/zone/epy.ovh/*&POST=/domain/zone/epy.ovh/*&DELETE=/domain/zone/epy.ovh/*). This link prefills the required authorizations.

- You can manage existing secrets here: https://www.ovh.com/manager/#/iam/api-keys

- Add them to `ovh.secrets.yml`
