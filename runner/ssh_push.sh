#!/bin/sh

exec ssh -i /etc/.ssh/id_rsa.pub -o StrictHostKeyChecking=no "$@"
