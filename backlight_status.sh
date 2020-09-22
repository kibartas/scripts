#!/bin/sh

echo "$(enlighten | grep -Eo '[0-9]{1,3}%')"
