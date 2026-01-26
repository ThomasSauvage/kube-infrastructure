# Add Cilium
helm repo add cilium https://helm.cilium.io/
helm repo update

# Install Cilium. ⚠️ Using a pre-release to have L2 LB IPv6 support
helm install cilium cilium/cilium --version 1.19.0-rc.0 \
   --namespace kube-system \
   --values cilium.helm-values.yml

# Enable Cilium Hubble, used for observability
cilium hubble enable --ui

# Check if Cilium is up and wait for it to become up
cilium status --wait
