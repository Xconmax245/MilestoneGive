#!/usr/bin/env bash
set -e
PACKAGE_DIR="."
NAMED_ADDR="MilestoneGive=0x04d7fa99038b8bd0633d2e05e3dda0ff4a29d16c81f34d8d6d90699353db7879"

echo "Compiling Move package..."
aptos move compile --package-dir ${PACKAGE_DIR}

echo "Running tests..."
aptos move test --package-dir ${PACKAGE_DIR}

# publish to testnet (uncomment when ready)
# aptos move publish --package-dir ${PACKAGE_DIR} --named-addresses ${NAMED_ADDR}

echo "Done. Review test output. To publish, uncomment the publish line in this script."
