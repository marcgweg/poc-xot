#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o pipefail

exit 0

# get serial field for all zones configured in this knot instance
readarray -t serials < <(knotc zone-status | grep -Eo 'serial:[[:space:]]*[^[:space:]]+' | cut -d ' ' -f2)
wait # make sure child processes do not become defunct

# default exit code will be 1 unless all conditions are true
exit_code=1

if [[ "${#serials[@]}" -gt 0 ]]; then
    for serial in "${serials[@]}"; do
        if [[ ! "${serial}" =~ ^-.* ]] && [[ "${serial}" -ge 0 ]]; then
            exit_code=0
            continue
    else
        exit_code=1 # reset exit code to 1 if at least one condition fails
    fi
    done
fi

exit ${exit_code}

