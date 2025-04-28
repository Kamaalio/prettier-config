set export

# List available commands
default:
    just --list --unsorted

# Publish package to NPM
publish:
    #!/bin/zsh
    
    if [[ -z $VERSION ]]
    then
        echo "Error: VERSION environment variable is not set or empty" >&2
        echo "Usage: VERSION=x.y.z just publish" >&2
        exit 1
    fi

    npm --no-git-tag-version version $VERSION
    pnpm publish --no-git-checks

# Install dependencies
install-modules:
    pnpm i

# Bootstrap project
bootstrap: enable-corepack install-modules

# Bootstrap for CI
[group("ci")]
[linux]
bootstrap-ci: install-zsh bootstrap

# Bootstrap for CI
[private]
[linux]
install-zsh:
    sudo apt-get update
    sudo apt-get install -y zsh

[private]
enable-corepack:
    corepack enable
