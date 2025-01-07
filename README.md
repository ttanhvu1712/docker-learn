# docker-learn

## 10 - K8s volume

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
