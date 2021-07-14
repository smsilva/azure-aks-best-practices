#!/bin/bash
time (
for DIRECTORY in $(find -maxdepth 1 -type d | sort | sed 1d); do
  echo "DIRECTORY.: ${DIRECTORY?}"
  echo ""

  terraform -chdir="${DIRECTORY?}" init
  terraform -chdir="${DIRECTORY?}" plan

  echo ""
  echo ""
  echo ""
done
)
