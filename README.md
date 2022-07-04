# aks-auto-upgrade

# Overview
Since spot node pools in Azure AKS are now automatically upgradeable - we can now have an automated script which upgrades both the control plane and all node pools in a single shot.

This script automatically detects all node pools and performs upgrade on all of them.

# Usage

Example usage:
```bash
cp .env-example .my-env
source .my-env
chmod u+x azure-aks-cluster-upgrade.sh
./azure-aks-cluster-upgrade.sh
```

Other potentially useful options:

```bash
./azure-aks-cluster-upgrade.sh --skip-nodepools # only upgrade control plane
# or
./azure-aks-cluster-upgrade.sh --skip-control-plane # only upgrade node pools
```



# Example runs

## Control plane

```bash
krasi@BGGLOBAL9115:~/Projects/pg/kube/scripts/cluster-upgrades$ ./cluster-upgrade.sh --skip-node-pools
Name     ResourceGroup     MasterVersion    Upgrades
-------  ----------------  ---------------  --------------
default  my-aks-cluster-rg  1.22.6           1.23.3, 1.23.5
Performing k8s control plane upgrade
Current control plane provisioning state: Upgrading
Current control plane provisioning state: Upgrading
Current control plane provisioning state: Upgrading
Current control plane provisioning state: Succeeded
Control plane has been upgraded
Script finished.
Name           Location     ResourceGroup     KubernetesVersion    CurrentKubernetesVersion    ProvisioningState    Fqdn
-------------  -----------  ----------------  -------------------  --------------------------  -------------------  ------------------------------------------------
my-aks-cluster  northeurope  my-aks-cluster-rg  1.23.3               1.23.3                      Succeeded            my-aks-cluster-XXXXXXX.hcp.northeurope.azmk8s.io
Name          OsType    KubernetesVersion    VmSize           Count    MaxPods    ProvisioningState    Mode
------------  --------  -------------------  ---------------  -------  ---------  -------------------  ------
my-nodepool-01  Linux     1.22.6               Standard_B2s     2        30         Succeeded            System
my-nodepool-02  Linux     1.22.6               Standard_B2s     1        30         Succeeded            User
my-spot-nodepool-03  Linux     1.22.6               Standard_E4s_v3  1        48         Succeeded            User

```


## Node pools

```bash
krasi:~/Projects/pg/kube/scripts/cluster-upgrades$ . my-cluster.sh 
ENV: my-cluster
K8SVERSION: 1.23.3
SUBSCRIPTION: XXXXXX-XXXXXX-XXXXX-XXXXX

krasi:~/Projects/pg/kube/scripts/cluster-upgrades$ ./cluster-upgrade.sh --skip-control-plane
Starting script. The following env vars are found:
ENV: my-cluster
K8SVERSION: 1.23.3
SUBSCRIPTION: XXXXXX-XXXXXX-XXXXX-XXXXX
Name          OsType    KubernetesVersion    VmSize           Count    MaxPods    ProvisioningState    Mode
------------  --------  -------------------  ---------------  -------  ---------  -------------------  ------
my-nodepool-00  Linux     1.22.6               Standard_B2s     2        30         Succeeded            System
my-nodepool-02  Linux     1.22.6               Standard_B2s     1        30         Succeeded            User
my-spot-nodepool-03  Linux     1.22.6               Standard_E4s_v3  1        48         Succeeded            User
2022-07-04T13-40-54zEEST Performing k8s node pool upgrade
2022-07-04T13-41-09zEEST Upgrading node pool my-nodepool-00
2022-07-04T13-41-29zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-42-12zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-42-51zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-43-29zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-44-06zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-44-37zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-45-08zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-45-42zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-46-17zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-46-56zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-47-32zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-48-03zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-48-35zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-49-10zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-49-41zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-50-12zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-50-43zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-51-14zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-51-57zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-52-28zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-53-04zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-53-36zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-54-08zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-54-44zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-55-25zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-55-56zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-56-28zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-56-59zEEST Current node pool provisioning state: Succeeded
2022-07-04T13-56-59zEEST Node pool my-nodepool-00 has been upgraded
2022-07-04T13-56-59zEEST Upgrading node pool my-nodepool-02
2022-07-04T13-57-09zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-57-52zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-58-26zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-59-14zEEST Current node pool provisioning state: Upgrading
2022-07-04T13-59-49zEEST Current node pool provisioning state: Upgrading
2022-07-04T14-00-20zEEST Current node pool provisioning state: Upgrading
2022-07-04T14-01-02zEEST Current node pool provisioning state: Upgrading
2022-07-04T14-01-33zEEST Current node pool provisioning state: Upgrading
2022-07-04T14-02-05zEEST Current node pool provisioning state: Upgrading
2022-07-04T14-02-36zEEST Current node pool provisioning state: Upgrading
2022-07-04T14-03-18zEEST Current node pool provisioning state: Upgrading
2022-07-04T14-04-02zEEST Current node pool provisioning state: Upgrading
2022-07-04T14-04-33zEEST Current node pool provisioning state: Upgrading
2022-07-04T14-05-16zEEST Current node pool provisioning state: Upgrading
2022-07-04T14-05-49zEEST Current node pool provisioning state: Succeeded
2022-07-04T14-05-49zEEST Node pool my-nodepool-02 has been upgraded
2022-07-04T14-05-49zEEST Upgrading node pool my-spot-nodepool-03
2022-07-04T14-05-56zEEST Current node pool provisioning state: Upgrading
2022-07-04T14-06-35zEEST Current node pool provisioning state: Upgrading
2022-07-04T14-07-18zEEST Current node pool provisioning state: Upgrading
2022-07-04T14-07-49zEEST Current node pool provisioning state: Upgrading
2022-07-04T14-08-20zEEST Current node pool provisioning state: Upgrading
2022-07-04T14-09-00zEEST Current node pool provisioning state: Upgrading
2022-07-04T14-09-31zEEST Current node pool provisioning state: Upgrading
2022-07-04T14-10-12zEEST Current node pool provisioning state: Succeeded
2022-07-04T14-10-12zEEST Node pool my-spot-nodepool-03 has been upgraded
2022-07-04T14-10-13zEEST Script finished.
Name           Location     ResourceGroup     KubernetesVersion    CurrentKubernetesVersion    ProvisioningState    Fqdn
-------------  -----------  ----------------  -------------------  --------------------------  -------------------  ------------------------------------------------
my-aks-cluster  northeurope  my-aks-cluster-rg  1.23.3               1.23.3                      Succeeded            my-aks-cluster-XXXXXX.hcp.northeurope.azmk8s.io
Name          OsType    KubernetesVersion    VmSize           Count    MaxPods    ProvisioningState    Mode
------------  --------  -------------------  ---------------  -------  ---------  -------------------  ------
my-nodepool-00  Linux     1.23.3               Standard_B2s     2        30         Succeeded            System
my-nodepool-02  Linux     1.23.3               Standard_B2s     1        30         Succeeded            User
my-spot-nodepool-03  Linux     1.23.3               Standard_E4s_v3  1        48         Succeeded            User
```

Note: cluster and node pool names have been redacted for privacy