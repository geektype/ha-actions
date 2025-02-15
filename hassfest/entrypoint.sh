#!/usr/bin/env bashio
declare -a integrations
declare integration_path

shopt -s globstar nullglob
for manifest in **/manifest.json; do
    integration_path=$(dirname "${manifest}")
    integrations+=(--integration-path "${integration_path}")
done

if [[ ${#integrations[@]} -eq 0 ]]; then
    bashio::exit.nok "No integrations found!"
fi

echo "printing integrations"
for integration in "${integrations[@]}"; do
    echo "$integration"
done


exec python3 -m script.hassfest --action validate "${integrations[@]}"
