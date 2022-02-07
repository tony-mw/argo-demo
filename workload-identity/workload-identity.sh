#!/bin/bash

#gcloud container clusters update primary-cluster \
#    --region=us-central1-a	 \
#    --workload-pool=ignite-argo-project-msd.svc.id.goog
# gcloud container node-pools update general-pool-08ac \
#    --cluster=primary-cluster \
#    --workload-metadata=GKE_METADATA \
#    --region=us-central1-a
#Run commands in link
#https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity

if [[ $1 == "sa" ]]; then
  k create serviceaccount argo-terraform
fi

if [[ $1 == "patch" ]]; then
  #patch
  for i in $( kubectl get deployments -n workflows --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}'); do
    kubectl patch deployments $i --patch-file ./workload-id-patch.yaml
  done
fi

if [[ $1 == "test" ]]; then
  #Test
  kubectl exec -it workload-identity-test \
    --namespace workflows \
    -- /bin/bash

  curl -H "Metadata-Flavor: Google" http://169.254.169.254/computeMetadata/v1/instance/service-accounts/
fi

