#!/bin/bash

if ! [ -x "$(command -v jq)" ]; then
    echo 'Error: jq is not installed.' >&2
    exit 1
fi

# Read credentials from file
credentials=$(cat credentials.json)
username=$(echo $credentials | jq -r '.username')
token=$(echo $credentials | jq -r '.token')

# check if the user name and token exist
if [ -z "$username" ] || [ -z "$token" ]; then
    echo "Error: credentials not found, please check your credentials.json file" >&2
    exit 1
fi

# Prompt the user to include forked repositories
while true; do
    read -p "Include forked repositories (y/N): " forked_repos
    if [ "$forked_repos" == "y" ] || [ "$forked_repos" == "n" ]; then
        break
    fi
done

# Create a directory to store the repositories
# Check if the directory exists and create it if it doesn't
if [ ! -d "$username" ]; then
    mkdir "$username"
fi

# Change to the directory
cd $username

# Get a list of repository URLs
curl -H "Authorization: token $token" "https://api.github.com/users/$username/repos?per_page=1000" | grep -o '"clone_url": "[^"]*' | awk '{print $2}' | sed 's/"//g' >repos.txt
# Get a list of forked repository URLs
if [ "$forked_repos" == "y" ]; then
    curl -H "Authorization: token $token" "https://api.github.com/users/$username/repos?per_page=1000&type=forks" | grep -o '"clone_url": "[^"]*' | awk '{print $2}' | sed 's/"//g' >>repos.txt
fi

# Clone/Pull all repositories and log the changes
clones=()
while read repo; do
    repo_name=$(echo $repo | awk -F/ '{print $NF}' | awk -F. '{print $1}')

    if [ -d $repo_name ]; then
        echo "$repo_name already exists, pulling changes..."
        cd $repo_name
        git pull
        last_update=$(git log -1 --format=%cd)
        cd ..
    else
        git clone $repo
        first_clone=$(date +%Y-%m-%d)
        last_update=$(date +%Y-%m-%d)
    fi
    clones+=("{\"repo_name\":\"$repo_name\",\"repo_link\":\"$repo\",\"first_clone\":\"$first_clone\",\"last_update\":\"$last_update\"}")
done <repos.txt

# Convert the clones array to a json file
echo "[$(
    IFS=,
    echo "${clones[*]}"
)]" >logging.json
