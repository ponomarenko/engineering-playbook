# Kubectl Cheat Sheet

## Context & Configuration

View contexts:

```bash
kubectl config get-contexts
```

Switch context:

```bash
kubectl config use-context dev
```

Check permissions:

```bash
kubectl auth can-i list pod --kubeconfig=my-sa-kubeconfig
```

## Pod Management

List pods:

```bash
kubectl get pods
kubectl get pods -n <namespace>
```

Sort pods by restart count (useful for finding unstable pods):

```bash
kubectl get pods --sort-by='.status.containerStatuses[0].restartCount'
```

## Logs

View logs of a specific pod:

```bash
kubectl -n <namespace> logs pod-name
```

Follow logs (`-f`):

```bash
kubectl -n <namespace> logs -f pod-name
```

Follow logs for all containers in a deployment:

```bash
kubectl -n <namespace> logs -f deployment/<app-name> --all-containers=true --since=10m
```

Logs for a specific container in a multi-container pod:

```bash
kubectl -n <namespace> logs pod-name -c container-name
```

Logs filtered by label:

```bash
kubectl -n <namespace> logs -l app=my-app
```

## Execution

Open a shell in a pod:

```bash
kubectl exec -it pod-name -n <namespace> /bin/bash
```

## Updating Resources

Update an image in a deployment:

```bash
kubectl -n <namespace> set image deployment/app-name container-name=image:tag
```

## Deletion

Delete pods matching a label (trigger restart):

```bash
kubectl -n <namespace> delete pod -l app=my-app
```
