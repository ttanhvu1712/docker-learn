# docker-learn

## 10 - K8s base

### K8s definition

K8s is an open src architecture that help us to:

- Create object pods, container,... to run your app
- Monitor pods, re-created or scaling them.
- Same k8s config should able to apply to providers: AWS, Azure, Google cloud,... and help to reduce the maintenance when change provider.

Our responsibility is setup cluster, node and api service,... and connect it to provider (such as `minikube` and `kubectl` in section below)

### K8s architect

https://www.simform.com/wp-content/uploads/2023/08/Kubernetes-Architecture-Diagram.jpg

K8s having 3 main object:

- Pod which holding containers and be the smallest object. Container in pods sharing volume and network (used same ip)
- Node which is classified as 2 type:

```
+----------------------------------------------------+
|                     Kubernetes Node                |
|                                                    |
|  +-------------------+  +-----------------------+  |
|  | Kubelet           |  | Kube-proxy           |   |
|  | - Manages Pods    |  | - Handles Networking |   |
|  | - Talks to CRI    |  | - Routes Traffic     |   |
|  +-------------------+  +-----------------------+  |
|                                                    |
|  +-------------------+  +-----------------------+  |
|  | Container Runtime  |  | CNI Plugins          |  |
|  | - Runs Containers  |  | - Sets up Networks   |  |
|  | - Pulls Images     |  | - Assigns IPs        |  |
|  +-------------------+  +-----------------------+  |
|                                                    |
|  +-------------------+                             |
|  | Storage Plugins   |                             |
|  | - Mount Volumes   |                             |
|  | - Manage PVs      |                             |
|  +-------------------+                             |
+----------------------------------------------------+
```

```
+------------------------------------------------------+
|        Kubernetes Master Node (Control plan)         |
|                                                      |
|  +-------------------+  +------------------------+   |
|  | kube-apiserver    |  | etcd (Cluster State)   |   |
|  | - Central API     |  | - Persistent Storage   |   |
|  | - Auth/Validate   |  | - Highly Available     |   |
|  +-------------------+  +------------------------+   |
|                                                      |
|  +-------------------+  +------------------------+   |
|  | kube-scheduler    |  | kube-controller-mgr    |   |
|  | - Assigns Pods    |  | - Ensures Desired      |   |
|  | - Resource Mgmt   |  |   Cluster State        |   |
|  +-------------------+  +------------------------+   |
|                                                      |
|  +-------------------+  +------------------------+   |
|  | cloud-controller  |  | CoreDNS (Networking)   |   |
|  | - Manages Cloud   |  | - DNS Resolution       |   |
|  |   Integrations    |  | - Service Discovery    |   |
|  +-------------------+  +------------------------+   |
+------------------------------------------------------+
```

- Cluster is the fundamental building block of Kubernetes, where all the components above and resources of a Kubernetes-managed environment operate together. Cluster is treated an separated machine.

### K8s installation locally

To run k8s locally we need 2 things:

- `kubectl` to execute k8s command and control the master node: https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/#install-with-homebrew-on-macos
- `minikube` to run a fake k8s cluster / virtual machine locally, then hosting the whole k8s systems: https://minikube.sigs.k8s.io/docs/start/?arch=%2Fmacos%2Farm64%2Fstable%2Fbinary+download (if you have docker installed, no need to install an virtual machine tool, just `minikube`)

### K8s command to run an container to deploy k8s in imperative ways.

- `kubectl`

  - Deployment:

    - Create deployment object from docker hub image: `kubectl create deployment [deployment_name] --image=[image_name]`
    - Get deployment: `kubectl get deployment`
    - Deleted deployment: `kubectl delete deployment [deployment_name]`
    - Update deployment with new image:
      - Update image in deployment: `kubectl set image deployment/[deployment_name] [current_container_image_name]=[update_image_name]`
      - Rollout the updated deployment: `kubectl rollout status deployment/[deployment_name]`
    - Check rollout history: `kubectl rollout history deployment/[deployment_name] --revision[version_number]`
    - Rollback image of deployment: `kubectl rollout undo deployment/[deployment_name] --to-revision=[version_number]`

  - Service:

    - Expose deployment object with an Service `kubectl expose deployment [deployment_name] --type=[service_type] --port=[port]`
    - Get exposed service: `kubectl get service`
    - Deleted service: `kubectl delete service [service_name]`

  - Pods:

    - Get number pod: `kubectl get pod`
    - Scale the service with replicas: `kubectl scale deployment/[deployment_name] --replicas=[number_replicas]`

- `minikube`

  - Start: `minikube start --driver=[driver-option]`
  - Check status: `minikube status`
  - Running local-dashboard: `minikube dashboard`
  - Expose service port to local machine that user can access: `minikube service [service_name_from_kubectl]`

### K8s command to run an container to deploy k8s in declarative ways.

- Create and config object from yaml file: `kubectl apply -f=[path_to_config_yaml_1],[path_to_config_yaml_2]`
- Delete object from yaml file: `kubectl delete -f=[path_to_config_yaml_1],[path_to_config_yaml_2]`
- Quick delete imperative deployment and service by lables: `kubectl delete deployment,service -l group=example`
