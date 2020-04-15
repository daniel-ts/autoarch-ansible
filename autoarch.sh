#!/bin/sh

hostname $1 \
    && ansible-pull -vv --accept-host-key --url "git@github.com:daniel-ts/autoarch-ansible.git" AutoarchBase.yml
