## Parallel jobs

Create a secret to hold the SonarQube/SonarCloud credentials:
```
kubectl create secret generic sonar --from-literal="opts=-Dsonar.host.url=..."
```

Generate the job expansions for all projects from `job.yaml` into the `jobs` folder:
```
./expand_jobs.sh job.yaml
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

Delete the previous deployment:
```
kubectl delete deployment sonarqube-deployment
```

Delete the previous service, or leave it running to keep the external IP unchanged:
```
kubectl delete service sonarqube-service
```

Create the new service and deployment:
```
kubectl create -f sonarqube.yaml
```

Get the service external IP address (relaunch if pending):
```
kubectl describe services sonarqube-service | grep "LoadBalancer Ingress"
```

Scale the deployment up or down:
```
kubectl scale deployment sonarqube-deployment --replicas=2
```

Update the deployment's Docker image (unsupported by SonarQube, will prematurely terminate the old pods):
```
kubectl set image deployment/sonarqube-deployment sonarqube=sonarqube:6.7.1
```

View the status of the new image rollout:
```
kubectl rollout status deployment/sonarqube-deployment
```

View all HTTP requests served by a given pod except for readiness probes:
```
kubectl logs -f [pod] | grep --line-buffered -F "serves" | grep -F -v "/api/system/status"
```

## Scientists job

Create the secret Google Cloud Storage:
```
kubectl create secret generic gcloud-storage --from-literal='token='`gcloud auth print-access-token`
```

Generate the job expansions for all projects from `scientists-job.yaml` into the `jobs` folder:
```
./expand_jobs.sh scientists-job.yaml
```

Run all the expanded jobs:
```
kubectl create -f ./jobs
```
