# Basic Kubernetes Commands

## Minikube

- `minikube version` - check minikube version and for a valid installation
- `minikube start` - start a Kubernetes cluster using minikube

## Kubectl Basics

- `kubectl version` - displays the client (kubectl) and server (Kubernetes) versions
- `kubectl cluster-info` - displal cluster details
- `kubectl get` - list resources
  - `kubectl get nodes` - view the nodes in the cluster
  - `kubectl get deployments` - list deployments
  - `kubectl get services` - list current services in the cluster
  - `kubectl get services -l <label>` - list services filtered by label
  - `kubectl get pods -l <label>` - list pods filtered by label
  - `kubectl get rs` - display the ReplicaSet created by a Deployment
  - `kubectl get pods -o wide` - this flag can be used with any command to produce a wide output
- `kubectl describe` - show detailed information about a resource
  - `kubectl describe pods` - view pods details such as containers and images used
  - `kubectl describe pods <pod-name>` view a single pod
  - `kubectl describe services/<service-name>` - display service info
  - `kubectl describe deployemnt` - display info about a deployment
- `kubectl logs` - print the logs from a container in a pod
- `kubectl exec` - execute a command on a container in a pod
  - `kubectl exec <pod-name> -- env` - list pod environment variables
  - `kubectl exec -it <pod-name> -- bash` - start a bash session in the pod's container
  - `kubectl exec -it <pod-name> -- curl localhost:<port>` - run a curl command on a pod
- `kubectl create` - create a resources from a file or from stdin
  - `kubectl create deployemnt <deployment-name> --image=<image-location>:<version>` - example deployment using stdin
- `kubectl proxy` - start a proxy to connect between a host and the Kubernetes cluster (direct access to API)
- `kubectl logs <pod-name>` - view app logs normally sent to stdout
- `kubectl expose <deployment-name> --type="<loadbalancer-type>" --port <service-port>` - create a new service
- `kubectl label pods <pod-name> <new-label=value>` - apply a new label
- `kubectl delete` - deletes a Kubernetes resources
  - `kubectl delete service -l <label>` - delete a service by label
- `kubectl scale deployments/<deployment-name> --replicas=<number-of-replicas>` - scale a deployment
- `kubectl set image deployments<deployment-name> <deployment-name>=<new-image-source>:<version>` - update an app image for rolling update
- `kubectl rollout status deployments/<deployment-name>` - confirm rollout status
- `kubectl rollout undo deployments/<deployment-name>` - roll back deployment to last working version
- `curl http://<host-node>:8001/version` - view the APIs hosted through the proxy endpoint
- `export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')` - set pod name variable
- `curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/` - access the pod through the API
- `curl $(minikube ip):<node-port>` test service exposure for app