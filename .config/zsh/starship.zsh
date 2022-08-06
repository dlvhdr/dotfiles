#!/bin/bash

if ! command -v starship &> /dev/null; then
  exit
fi

eval "$(starship init zsh)"

