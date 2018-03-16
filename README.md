Create a secret to hold the SonarQube/SonarCloud credentials:
```
kubectl create secret generic sonar --from-literal="opts=-Dsonar.host.url=..."
```

Generate the job expansions into the `jobs` folder:
```
./generate_jobs.sh
```

Run all the generated jobs:
```
kubectl create -f ./jobs
```

Run a specific generated job:
```
kubectl create -f ./jobs/job-project.yaml
```

List all pods:
```
kubectl get pods --show-all
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

Delete all the jobs and their associated resources (pods, logs):
```
kubectl delete job --selector "jobgroup=peach-java"
```
