#!/usr/bin/env bash

COMPOSE_DIR="/work/compose"
CLONE_DIR="/work/repo"
CI_COMMIT="main"
if [ -z "$CI_REPO_URL" ]; then
  REPO_URL="https://github.com/dr460nf1r3/commitlint-poc"
fi
#if [ -z "$CI_TAG" ] || [ -z "$CI_COMMIT" ]; then
#  echo "You need to provide a tag and commit to pull images from!"
#  exit 1
#fi
#if [ -z "$CI_BITBUCKET_TOKEN" ] || [ -z "$CI_DOCKERHUB_TOKEN" ]; then
#  echo "You need to provide a working BitBucket and DockerHub token for repository access!"
#  exit 1
#fi

function init() {
  # Run original entrypoint annd wait for the daemon to start
  dockerd-entrypoint.sh &
  sleep 10

  mkdir /work
  mkdir -p "$COMPOSE_DIR"

  git clone --depth 20 "$REPO_URL" "$CLONE_DIR"
  cd "$CLONE_DIR" || exit
  git checkout "$CI_COMMIT"
}

function buildCompose() {
  #node ./ci/build-compose.js
  #cp -v ./dist/compose.yml "$COMPOSE_DIR"
  cp /compose.yaml "$COMPOSE_DIR/compose.yaml"
}

function main() {
  init
  buildCompose

  pushd "$COMPOSE_DIR" || exit
  docker compose up
  popd || exit
}

main
