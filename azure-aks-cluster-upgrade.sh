#!/bin/bash

if [[ -z $ENV ]]; then echo "Error: no ENV set!" && exit 1; fi
if [[ -z $K8SVERSION ]]; then echo "Error: no K8SVERSION set!" && exit 1; fi
if [[ -z $SUBSCRIPTION ]]; then echo "Error: no SUBSCRIPTION set!" && exit 1; fi


function dateNow { echo `date +%Y-%m-%dT%H-%M-%Sz%Z`; } 
skipControlPlane=false
skipNodepools=false

echo "Starting script. The following env vars are found:"
echo ENV: $ENV
echo K8SVERSION: $K8SVERSION
echo SUBSCRIPTION: `az account show | jq -r .name`


for param in "$@"; 
do
    case $param in
        --skip-control-plane)
            skipControlPlane=true
            shift
            ;;
        --skip-node-pools)
            skipNodepools=true
            shift
            ;;
        *)
            ;;
    esac
done

if [[ $skipControlPlane != true ]]; then
    az aks get-upgrades -g ${ENV}aks-rg -n ${ENV}aks -o table
    echo "$(dateNow) Performing k8s control plane upgrade"
    az aks upgrade -g ${ENV}aks-rg --name ${ENV}aks --kubernetes-version $K8SVERSION --control-plane-only --no-wait --yes


    for (( i=0; i < 100; i++ ))
    do
        provisioningState=`az aks show -g ${ENV}aks-rg --name ${ENV}aks | jq -r .provisioningState`
        echo "$(dateNow) Current control plane provisioning state: $provisioningState"
        if [[ $provisioningState == "Failed" ]]; then echo "$(dateNow) Error found." && exit 1; fi
        if [[ $provisioningState == "Succeeded" ]]; then echo "$(dateNow) Control plane has been upgraded" && break; fi
        sleep 30

    done
fi


if [[ $skipNodepools != true ]]; then
    az aks nodepool list -g ${ENV}aks-rg --cluster-name ${ENV}aks -o table
    echo "$(dateNow) Performing k8s node pool upgrade"
    nodepools=`az aks nodepool list -g ${ENV}aks-rg --cluster-name ${ENV}aks | jq -r .[].name`
    for each in $nodepools
    do
        echo "$(dateNow) Upgrading node pool $each"
        az aks nodepool upgrade -g ${ENV}aks-rg --cluster-name ${ENV}aks --name $each --kubernetes-version ${K8SVERSION} --no-wait
        sleep 2
        for (( np=0; np < 120; np++ ))
        do
            nodepoolProvisioningState=`az aks nodepool list -g ${ENV}aks-rg --cluster-name ${ENV}aks | jq -r ".[] | select(.name==\"${each}\") | .provisioningState "`
        echo "$(dateNow) Current node pool provisioning state: $nodepoolProvisioningState"
            if [[ $nodepoolProvisioningState == "Failed" ]]; then echo "$(dateNow) Error found." && exit 1; fi
            if [[ $nodepoolProvisioningState == "Succeeded" ]]; then echo "$(dateNow) Node pool $each has been upgraded" && break; fi 
            sleep 30
        done
    done
fi

echo "$(dateNow) Script finished."
az aks show -g ${ENV}aks-rg --name ${ENV}aks -o table
az aks nodepool list -g ${ENV}aks-rg --cluster-name ${ENV}aks -o table
