#!/bin/bash

# Check if a URL was provided as an environment variable
if [ -z "$URL" ]; then
  echo "Usage: URL=<url> bash <script>"
  echo "Please provide the URL as an environment variable."
  exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
  echo "npm is not found. Please install Node.js and npm, then run this script again."
  exit 1
fi

# Check if newman is installed
if ! command -v newman &> /dev/null; then
  echo "newman is not found. Installing..."
  npm install -g newman
fi

# Inform the user that the process may take some time
cat << "EOF"


                           _     _____           _                  _ 
     /\                   | |   |  __ \         | |                | |
    /  \   __ _  ___ _ __ | |_  | |__) | __ ___ | |_ ___   ___ ___ | |
   / /\ \ / _` |/ _ \ '_ \| __| |  ___/ '__/ _ \| __/ _ \ / __/ _ \| |
  / ____ \ (_| |  __/ | | | |_  | |   | | | (_) | || (_) | (_| (_) | |
 /_/    \_\__, |\___|_| |_|\__| |_|   |_|  \___/ \__\___/ \___\___/|_|
           __/ |                                                      
          |___/                                                       


Made possible by:
- e2b
- Allen Helton
- Postman
- Auto-GPT

Running the tests, this might take a while. Please wait...

EOF

newman run https://raw.githubusercontent.com/e2b-dev/agent-protocol/main/testing_suite/contract_tests.json \
-e https://raw.githubusercontent.com/e2b-dev/agent-protocol/main/testing_suite/contract_tests_env.json \
--env-var "env-openapi-json-url=https://raw.githubusercontent.com/e2b-dev/agent-protocol/main/schemas/openapi.json" \
--env-var "env-server=Test server"

agent_protocol_contract_testing_results=$?

if [[ $agent_protocol_tests_results -ne 0 ]] || [[ $agent_protocol_contract_testing_results -ne 0 ]]; then
    exit 1
else
    exit 0
fi
