# Google Cloud Platform (GCP) Authentication

## gsutil Configuration

Configure `gsutil` interactively:

```bash
gsutil config -e
```

## Service Account Activation

Activate a service account using a key file:

```bash
gcloud auth activate-service-account --key-file=/path/to/service-account-key.json
```
