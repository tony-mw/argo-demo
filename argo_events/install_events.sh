#!/bin/bash

helm repo add argo https://argoproj.github.io/argo-helm
helm install argo-events argo/argo-events