
#Creating a namespace

```sh
➜  k8-demo kubectl create namespace k8-demo                      
namespace "k8-demo" created

➜  k8-demo kubectl config set-context k8-demo --namespace=k8-demo --cluster=default-cluster --user=default-admin

context "k8-demo" set.
➜  k8-demo kubectl config use-context k8-demo
switched to context "k8-demo".
```

## Create secrets

### registry secrets

```sh
kubectl create secret docker-registry demo-key \
  --docker-server=registry.env.intra.local.ch \
  --docker-username=alex \
  --docker-password=8ZQ2ZbJJY5fjkkyJ72No \
  --docker-email=alejandro.ramirez.ch@localsearch.ch
```

### configuration secrets
```sh
kubectl create secret generic weather-config-prod --from-file manifests/config.edn
```
### decode

```sh
kubectl get secret weather-config-prod -o yaml |grep config.edn|cut -f2 -d":"| base64 -D
```



## Deployment


### Service

```
kubectl expose deployment weather-app --port=80 --target-port=8080
```
