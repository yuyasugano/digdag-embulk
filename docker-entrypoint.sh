#!/bin/bash
set -e

server() {
  envsubst < config.template.yml > config.yml.tmp
  mv config.yml.tmp config.yml

  exec java -jar /usr/local/bin/digdag server -m -b 0.0.0.0 -P config.yml -X io.digdag.limits.maxWorkflowTasks=100000 -c allow.properties --log /var/lib/digdag/logs/server --task-log /var/lib/digdag/logs/tasks
}

case "$1" in
  server)
    shift
    server
    ;;
  *)
    exec "$@"
    ;;
esac

