#!/bin/bash

if ! command -v zoxide &> /dev/null; then
  exit
fi

eval "$(zoxide init zsh --cmd j)"
