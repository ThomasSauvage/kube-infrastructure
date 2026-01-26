##Secret management

Secrets are managed outside of ArgoCD, and applied manually using the following command:

```sh
kubectl apply -f "bootstrap/*.secrets.yml"
```

## OVH secret generation

- We use Let's encrypt and OVH certificate DNS01 challenges

- To generate the OVH secrets:
  - Connect to ovh.com
  - Create a secret at: [ovh.com/...](https://www.ovh.com/auth/api/createToken?GET=/domain/zone/&GET=/domain/zone/epy.ovh/*&PUT=/domain/zone/epy.ovh/*&POST=/domain/zone/epy.ovh/*&DELETE=/domain/zone/epy.ovh/*). This link prefills the required authorizations.

- You can manage existing secrets here: https://www.ovh.com/manager/#/iam/api-keys

- Add them to `ovh.secrets.yml`
