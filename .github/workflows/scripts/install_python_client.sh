#!/bin/bash

# WARNING: DO NOT EDIT!
#
# This file was generated by plugin_template, and is managed by it. Please use
# './plugin-template --github pulpcore' to update this file.
#
# For more info visit https://github.com/pulp/plugin_template

set -mveuo pipefail

# make sure this script runs at the repo root
cd "$(dirname "$(realpath -e "$0")")"/../../..

source .github/workflows/scripts/utils.sh

export PULP_URL="${PULP_URL:-https://pulp}"

REPORTED_STATUS="$(pulp status)"
REPORTED_VERSION="$(echo "$REPORTED_STATUS" | jq --arg plugin "core" -r '.versions[] | select(.component == $plugin) | .version')"
VERSION="$(echo "$REPORTED_VERSION" | python -c 'from packaging.version import Version; print(Version(input()))')"

pushd ../pulp-openapi-generator
rm -rf pulpcore-client
./generate.sh pulpcore python "$VERSION"
pushd pulpcore-client
python setup.py sdist bdist_wheel --python-tag py3

twine check "dist/pulpcore_client-$VERSION-py3-none-any.whl"
twine check "dist/pulpcore-client-$VERSION.tar.gz"

cmd_prefix pip3 install "/root/pulp-openapi-generator/pulpcore-client/dist/pulpcore_client-${VERSION}-py3-none-any.whl"
tar cvf ../../pulpcore/core-python-client.tar ./dist

find ./docs/* -exec sed -i 's/Back to README/Back to HOME/g' {} \;
find ./docs/* -exec sed -i 's/README//g' {} \;
cp README.md docs/index.md
sed -i 's/docs\///g' docs/index.md
find ./docs/* -exec sed -i 's/\.md//g' {} \;

cat >> mkdocs.yml << DOCSYAML
---
site_name: Pulpcore Client
site_description: Core bindings
site_author: Pulp Team
site_url: https://docs.pulpproject.org/pulpcore_client/
repo_name: pulp/pulpcore
repo_url: https://github.com/pulp/pulpcore
theme: readthedocs
DOCSYAML

# Building the bindings docs
mkdocs build

tar cvf ../../pulpcore/core-python-client-docs.tar ./docs
popd
rm -rf pulp_file-client
./generate.sh pulp_file python "$VERSION"
pushd pulp_file-client
python setup.py sdist bdist_wheel --python-tag py3

twine check "dist/pulp_file_client-$VERSION-py3-none-any.whl"
twine check "dist/pulp_file-client-$VERSION.tar.gz"

cmd_prefix pip3 install "/root/pulp-openapi-generator/pulp_file-client/dist/pulp_file_client-${VERSION}-py3-none-any.whl"
tar cvf ../../pulpcore/file-python-client.tar ./dist

find ./docs/* -exec sed -i 's/Back to README/Back to HOME/g' {} \;
find ./docs/* -exec sed -i 's/README//g' {} \;
cp README.md docs/index.md
sed -i 's/docs\///g' docs/index.md
find ./docs/* -exec sed -i 's/\.md//g' {} \;

cat >> mkdocs.yml << DOCSYAML
---
site_name: PulpFile Client
site_description: File bindings
site_author: Pulp Team
site_url: https://docs.pulpproject.org/pulp_file_client/
repo_name: pulp/pulp_file
repo_url: https://github.com/pulp/pulp_file
theme: readthedocs
DOCSYAML

# Building the bindings docs
mkdocs build

tar cvf ../../pulpcore/file-python-client-docs.tar ./docs
popd
popd
