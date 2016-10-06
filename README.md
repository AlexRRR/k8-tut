
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

Show app, and configuration file.

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

### create Ingress

```sh
kubectl create -f ingress.yaml
```
view Ingress

```sh
kubectl get ing
```

### deployments
try to access with Ingress
```sh
kubectl create -f weather-deployment-kelvin.yaml --record
```

rollout status

```sh
 kubectl rollout status deploy weather-app
```

upgrade app

```
kubectl apply -f weather-deployment-imperial.yaml --record
```

rollout history
```
kubectl rollout history deployment weather-app
```

rollback to version
```
kubectl rollout undo deployment weather-app --to-revision=5
```

Canary release
```
kubectl create -f weather-deployment-metric-canary.yaml --record
```

## Autoscaling (Horizontal Pods Autoscaling)


Start a the pod  to be scaled
```sh
kubectl run php-apache --image=gcr.io/google_containers/hpa-example \    
  --requests=cpu=500m,memory=500M --expose --port=80
```

Test the service
```
kubectl run -i --tty service-test --image=busybox /bin/sh    

# once inside the container run

wget -q -O- http://php-apache.k8-demo.svc.cluster.local
```

Start the autoscaled

```sh
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
```

monitor the scaled

```sh
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
### watch the number of Pods
kubectl get pods    
```



## Cool things

ui
```
kubectl proxy
```

port foward
```
kubectl get pods
kubectl port-forward somepod 8080 --namespace=kube-system
```

access shell
```
kubectl exec -ti [-c container-name] somepod bash
```

top
```
kubectl top nodes
kubectl top pods
```
