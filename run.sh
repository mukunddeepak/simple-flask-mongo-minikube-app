minikube start
helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install sealed-secrets -n kube-system --set-string fullnameOverride=sealed-secrets-controller sealed-secrets/sealed-secrets
helm upgrade --install loki grafana/loki-stack --set grafana.enabled=true,prometheus.enabled=true -n loki --create-namespace
kubeseal --controller-name=sealed-secrets-controller --controller-namespace=kube-system --format yaml --cert mycert.pem < ./mongo-secret.yaml > ./mongo-sealedsecret.yaml
kubectl apply -f ./mongo_config.yaml
kubectl apply -f ./mongo-sealedsecret.yaml
kubectl apply -f ./flaskapp_deployment.yaml
kubectl apply -f ./loadbalancer.yaml
kubectl apply -f ./mongo.yaml
kubectl apply -f ./mongo-svc.yaml
kubectl apply -f ./mongo-pv.yaml
kubectl apply -f ./mongo-pvc.yaml
sleep 60 && echo "Waiting for Deployment!"
kubectl get svc
kubectl get pv
kubectl get pvc
curl $( minikube service flaskapp-svc --url )
kubectl port-forward --namespace loki service/loki-grafana 3000:80
