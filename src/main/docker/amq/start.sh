#!/bin/bash
set -e

IFS=', ' read -r -a array <<< "$WAIT_FOR"
for element in "${array[@]}"
do
    /usr/local/bin/dockerize -wait tcp://$element -wait-retry-interval 2s -timeout 600s
done

echo "All dependencies are online. Starting up this service now."

./amq/bin/artemis create /opt/broker --user $AMQ_USER --password $AMQ_PASSWORD --require-login

/opt/broker/bin/artemis "$@"
