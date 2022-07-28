minikube start
kubectl apply -f ./mongo_config.yaml
kubectl apply -f ./mongo-secret.yaml
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
