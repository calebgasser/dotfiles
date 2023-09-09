#!/bin/sh
echo "command: nix build .#homeManagerConfigurations.cgasser.activationPackage"
echo "command: ./result/activate"
nix build .#homeManagerConfigurations.cgasser.activationPackage $1
./result/activate
