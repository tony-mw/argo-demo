#!/bin/bash

if [[ $1 == "patch" ]]; then
  #patch
  for i in $( kubectl get deployments -n workflows --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}'); do
    kubectl patch deployments $i --patch-file workload-id-patch.yaml
  done
fi

if [[ $1 == "test" ]]; then
  #Test
  kubectl exec -it workload-identity-test \
    --namespace workflows \
    -- /bin/bash

  curl -H "Metadata-Flavor: Google" http://169.254.169.254/computeMetadata/v1/instance/service-accounts/
fi
