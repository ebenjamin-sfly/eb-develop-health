POOL="github-pool"
PROVIDER="github-provider"
PROJECT_ID="$(gcloud config get-value project)"

gcloud iam workload-identity-pools create $POOL \
  --project="$PROJECT_ID" \
  --location="global" \
  --display-name="GitHub Actions Pool"

gcloud iam workload-identity-pools providers create-oidc $PROVIDER \
  --project="$PROJECT_ID" \
  --location="global" \
  --workload-identity-pool=$POOL \
  --display-name="GitHub Provider" \
  --attribute-mapping="google.subject=assertion.sub,attribute.repository=assertion.repository" \
  --issuer-uri="https://token.actions.githubusercontent.com"

