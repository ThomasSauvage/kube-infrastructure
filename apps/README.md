# Apps

This directory contains applications to be deployed on the Kubernetes cluster.

## Network Policies

By default, **no network policies are applied**. When a pod is subject to any network policy, then it will **deny all traffic** that is not explicitly allowed.

Therefore, all pods **MUST have at least one network policy**, to explicitly allow some traffic to/from them and automatically disallow all other traffic.

This network policy can either be a `CiliumNetworkPolicy`, `NetworkPolicy`, or applied through a **label**.

List of network policies labels we defined (see [network-policies.yml](./network-policies.yml)):

- `security-gateway-accessible=true`: allows traffic through the Envoy Gateway.
