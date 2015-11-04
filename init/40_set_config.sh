#!/bin/bash

# Check if config exists. If not, copy in from /defaults
[[ ! -f /config/polipo.conf ]] && cp /defaults/polipo.conf /config/polipo.conf

# Verify and create directory
[[ ! -e /config/cache ]] && mkdir -p /config/cache

chown abc /config/cache
