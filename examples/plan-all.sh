#!/bin/bash
clear

time (
for DIRECTORY in $(find -maxdepth 1 -type d | sort | sed 1d); do
  terraform -chdir="${DIRECTORY?}" init &> /dev/null
  INIT=$?

  terraform -chdir="${DIRECTORY?}" plan &> /dev/null
  PLAN=$?

  echo "[INIT=${INIT} PLAN=${PLAN}] ${DIRECTORY?}"
done
)
