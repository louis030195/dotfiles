#!/bin/bash
python3 -m venv .my_super_env && # Yeah random name to avoid erasing local virtualenv
	source .my_super_env/bin/activate &&
	pip install pyyaml &&
	python3 -c "import yaml, json, sys
sys.stdout.write(yaml.dump(json.load(sys.stdin)))" \
	< $1 > $2
# Remove the temporary venv in any case
rm -rf .my_super_env
