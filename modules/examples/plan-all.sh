#!/bin/bash
time (
for EXAMPLE in $(find -maxdepth 1 -type d | sort | sed 1d); do
  terraform -chdir="${EXAMPLE?}" init
  terraform -chdir="${EXAMPLE?}" plan
done
)
