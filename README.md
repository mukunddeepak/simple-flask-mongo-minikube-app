# This is a Simple Flask App Deployed in Kubernetes which communicates with a database deployed in the same cluster.
## Kubernetes Node Used: Minikube
### Prerequisites:
* Minikube installed in local setup
* kubectl installed in local setup
* Docker installed in local setup
* kubeseal installed in local setup [Kubeseal](https://github.com/bitnami-labs/sealed-secrets)

### Developer features:
* Prometheus - Metric Monitoring Tool
* Grafana Loki - Logging Tool

**Persistence has not been enabled so all data is lost once grafana pod dies!**

**Please add any issues if any and i'll try to resolve them whenever i can!**

### Just do ```bash run.sh``` after installing all prerequisites and it will generate the URL to interact with the server
### Enjoy this project :)

