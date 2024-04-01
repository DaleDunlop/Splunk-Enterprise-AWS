#!/usr/bin/env bash

 # Install kubectl
      if ! kubectl version --client &> /dev/null; then
        curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
        chmod +x ./kubectl
        sudo mv ./kubectl /usr/local/bin/kubectl
      fi

      # Install Helm
      if ! helm version --client &> /dev/null; then
        curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
      fi

      # Install Minikube
      if ! minikube version &> /dev/null; then
        cd /workspace
        curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
        chmod +x minikube
        sudo install minikube /usr/local/bin/
        cd $THEIA_WORKSPACE_ROOT
      fi