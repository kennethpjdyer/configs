#! /usr/bin/bash

# Pinger
ping -c 1 www.google.com | head -n 2 | tail -n 1 | awk '{print $8}' | cut -c 6-


