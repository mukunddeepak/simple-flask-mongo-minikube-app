minikube start
echo "Deleting existing deployments, services, secrets, configmaps, pv and pvc"
kubectl delete deploy --all
kubectl delete svc --all
kubectl delete sealedsecrets.bitnami.com --all
kubectl delete secrets --all
kubectl delete pvc --all
kubectl delete pv --all
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install sealed-secrets-controller -n kube-system sealed-secrets/sealed-secrets
helm upgrade --install loki grafana/loki-stack --set grafana.enabled=true,prometheus.enabled=true -n loki --create-namespace
kubectl apply -f ./mongo_config.yaml
kubeseal --cert ./cert.pem < ./mongo-secret.yaml > ./mongo-sealedsecret.yaml
kubectl apply -f ./mongo-sealedsecret.yaml
kubectl apply -f ./flaskapp_deployment.yaml
kubectl apply -f ./loadbalancer.yaml
kubectl apply -f ./mongo.yaml
kubectl apply -f ./mongo-svc.yaml
kubectl apply -f ./mongo-pv.yaml
kubectl apply -f ./mongo-pvc.yaml
kubectl rollout status deployment/flaskapp
kubectl rollout status deployment/mongo
kubectl get svc
kubectl get pv
kubectl get pvc
curl $(minikube service flaskapp-svc --url)
kubectl port-forward --namespace default service/loki-grafana 3000:80
