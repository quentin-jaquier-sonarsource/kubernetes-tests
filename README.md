Create a Kubernetes secret to hold the SonarQube/SonarCloud credentials:
```
kubectl create secret generic sonar --from-literal="opts=-Dsonar.host.url=..."
```

Run a Kubernetes job:
```
kubectl delete job peach-java; kubectl create -f job.yaml && kubectl get pods --show-all && sleep 5 && kubectl logs --selector "jobgroup=peach-java"
```

List all Kubernetes pods:
```
kubectl get pods --show-all
```

Stream the logs from a Kubernetes pod:
```
kubectl logs -f [pod-name]
```
