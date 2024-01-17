#!/usr/bin/env bash
_getHeader "$name" "$author"

sel=""
_getConfSelector animation.conf animations
_getConfEditor animation.conf $sel animations
_reloadModule