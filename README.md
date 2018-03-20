## Parallel jobs

Create a secret to hold the SonarQube/SonarCloud credentials:
```
kubectl create secret generic sonar --from-literal="opts=-Dsonar.host.url=..."
```

Generate the job expansions for all projects from `job.yaml` into the `jobs` folder:
```
./expand_jobs.sh
```

Run all the expanded jobs:
```
kubectl create -f ./jobs
```

Run a specific expanded job:
```
kubectl create -f ./jobs/job-[project].yaml
```

List all pods (including terminated ones):
```
kubectl get pods --show-all
```

Get details about a specific pod:
```
kubectl describe pod [pod-name]
```

Stream the logs from a pod:
```
kubectl logs -f [pod-name]
```

Get the logs for all jobs:
```
kubectl logs --selector "jobgroup=peach-java"
```

List all nodes (managed by cluster-autoscaler):
```
kubectl get nodes
```

Delete all expanded jobs and their associated resources (pods, logs):
```
kubectl delete job --selector "jobgroup=peach-java"
```

## SonarQube instance

Create a secret to hold the JDBC credentials:
```
kubectl create secret generic sonarqube-jdbc --from-literal="user=postgres" --from-literal="pass=..." --from-literal="url=jdbc:postgresql://.../sonar"
```

Delete the previous service and deployment:
```
kubectl delete service sonarqube-service
kubectl delete deployment sonarqube-deployment
```

Create the new service and deployment:
```
kubectl create -f sonarqube.yaml
```

Get the service external IP address (relaunch if pending):
```
kubectl get services
```

Scale the deployment up or down:
```
kubectl scale deployment sonarqube-deployment --replicas=3
```

Update the SonarQube Docker image (will kill former pods):
```
kubectl set image deployment/sonarqube-deployment sonarqube=sonarqube:6.7.1
```

View the status of the new image rollout:
```
kubectl rollout status deployment/sonarqube-deployment
```
