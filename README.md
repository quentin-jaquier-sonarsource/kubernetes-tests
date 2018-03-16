Create a Kubernetes secret to hold the SonarQube/SonarCloud credentials:
```
kubectl create secret generic sonar --from-literal="opts=-Dsonar.host.url=..."
```

Generate the job expansions into the `jobs` folder:
```
./generate_jobs.sh
```

Run all the generated Kubernetes jobs:
```
kubectl create -f ./jobs
```

Run a specific generated Kubernetes job:
```
kubectl create -f ./jobs/job-project.yaml
```

List all Kubernetes pods:
```
kubectl get pods --show-all
```

Stream the logs from a Kubernetes pod:
```
kubectl logs -f [pod-name]
```

Get the logs for all the jobs:
```
kubectl logs --selector "jobgroup=peach-java"
```

List all Kubernetes nodes (managed by cluster-autoscaler):
```
kubectl get nodes
```

Delete all the jobs and their associated resources (pods, logs):
```
kubectl delete job --selector "jobgroup=peach-java"
```
