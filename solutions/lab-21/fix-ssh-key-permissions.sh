#!/usr/bin/env bash

# SSH is fussy about who can see the keys so lets make sure they are good
chmod a-w study-group*
chmod a+r study-group.pub
chmod 0400 study-group
