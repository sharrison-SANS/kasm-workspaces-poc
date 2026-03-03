#!/bin/sh

# Adapted from kasmtech/workspaces_registry_template.
# This script runs from the repo root.

REGISTRY_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REGISTRY_DIR"

# Map branch names to output directory names.
# The default branch is mapped to the schema version so that the
# registry URL uses a version path (e.g. /1.1/) instead of /main/.
SCHEMA_VERSION="1.1"
DEFAULT_BRANCH=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')

mkdir -p base
cat > base/index.html << EOF
<meta http-equiv="refresh" content="0; url=./$SCHEMA_VERSION/">
EOF
touch base/.nojekyll

echo "All branches:"
git fetch --all
echo "$(git branch --remotes --format '%(refname:lstrip=3)' | grep -Ev '^(HEAD|develop|gh-pages)$')"
for BRANCH in $(git branch --remotes --format '%(refname:lstrip=3)' | grep -Ev '^(HEAD|develop|gh-pages)$'); do
    if [ "$BRANCH" = "$DEFAULT_BRANCH" ]; then
        SANITIZED_BRANCH="$SCHEMA_VERSION"
    else
        SANITIZED_BRANCH="$(echo $BRANCH | sed 's/\//_/g')"
    fi
    echo "$SANITIZED_BRANCH" >> base/versions.txt
    git checkout --force $BRANCH
    cd "$REGISTRY_DIR"
    node processing
    cp -a public/. process
    sed -i "s/1.0/$SANITIZED_BRANCH/" site/next.config.js
    npm install --quiet --prefix site
    npm run deploy --prefix site
    cp -a process/. public/
    rm -rf process
    sed -i "s/$SANITIZED_BRANCH/1.0/" site/next.config.js
    mv public base/$SANITIZED_BRANCH
    cp base/$SANITIZED_BRANCH/favicon.ico base/favicon.ico
done

mv base public
