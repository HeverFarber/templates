#!/usr/bin/env bash

# Expected value
EXPECTED_VALUE="secret1"

# Check if ENV_VAR matches the expected value
if [ "$SECRET" != "$EXPECTED_VALUE" ]; then
  echo "Error: SECRET is not equal to '$EXPECTED_VALUE'."
fi
