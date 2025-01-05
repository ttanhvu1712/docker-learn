# docker-learn

## 10 - K8s base

### K8s definition

K8s is an open src architecture that help us to:

- Sharing same config of container services for providers: AWS, Azure, Google cloud,...
- The config should help to:
  - Restart the container when it crashed
  - Distribute the traffic to number of container.
  - Sharing resource (cpu, memory,...) among container.

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

### K8s command to run an container

- `kubectl`

  - Create deployment object from docker hub image: `kubectl create deployment [deployment_name] --image=[image_name]`
  - Get deployment: `kubectl get deployment`
  - Deleted deployment: `kubectl delete deployment [deployment_name]`
  - Expose deployment object with an Service `kubectl expose deployment [deployment_name] --type=[service_type] --port=[port]`
  - Deleted service: `kubectl delete service [service_name]`

- `minikube`

  - Start: `minikube start --driver=[driver-option]`
  - Check status: `minikube status`
  - Running local-dashboard: `minikube dashboard`
  - Expose service port to local machine that user can access: `minikube service [service_name_from_kubectl]`
