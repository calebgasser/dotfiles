#!/bin/sh
echo "command: sudo nixos-rebuild switch --flake .#$1"
sudo nixos-rebuild switch --flake .#$1
