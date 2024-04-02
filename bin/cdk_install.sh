#!/usr/bin/env bash

# Install CDK
      if ! cdk --version &> /dev/null; then
        npm i -g aws-cdk
      fi