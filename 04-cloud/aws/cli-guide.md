# AWS CLI Snippets

## ECR (Elastic Container Registry) Login

Login Docker to AWS ECR:

```bash
aws ecr get-login-password | docker login --username AWS --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com
```

## SSO Login

Login with AWS SSO profile:

```bash
aws sso login --profile development
```

## EMR (Elastic MapReduce)

List active clusters:

```bash
aws emr list-clusters --active
```

## MediaStore

List containers:

```bash
aws mediastore list-containers
```

## Interactive Pod Debugging (EKS)

Exec into a pod shell:

```bash
kubectl exec -i -t -n <NAMESPACE> <POD_NAME> "--" sh -c "clear; (bash || ash || sh)"
```

## Nginx Access Logs (on EC2/Container)

Monitor Nginx logs:

```bash
cd /etc/nginx/
tail -f /var/log/nginx/api.access.log
```
