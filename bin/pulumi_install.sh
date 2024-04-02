#!/usr/bin/env bash

# Install pulumi
      if ! pulumi &> /dev/null; then
        curl -fsSL https://get.pulumi.com | sh
      fi