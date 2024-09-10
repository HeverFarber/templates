#!/usr/bin/env bash

# Expected value
EXPECTED_VALUE="secret1"

# Check if ENV_VAR matches the expected value
if [ "$SECRET" != "$EXPECTED_VALUE" ]; then
  echo "Error: ENV_VAR is not equal to '$EXPECTED_VALUE'."
  exit 1
fi
