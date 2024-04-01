#!/usr/bin/env bash

# Install AWS CLI
      if ! aws --version &> /dev/null; then
        cd /workspace
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
        rm -rf aws awscliv2.zip
        cd $THEIA_WORKSPACE_ROOT
      fi