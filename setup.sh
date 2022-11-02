#!/usr/bin/env bash
set -euo pipefail

START=$(date +%s)
if [ -z "$1" ]; then
    LOGS+=" - ERROR: (1) PARAMS required"
	echo $LOGS
	echo "usage:"
	echo "./setup.sh your-app"
  printf "\r\033[00;35mMust be lowercase.\033[0m\n"
	exit 255;
fi

APP_NAME=$1

info() {
  printf "\r\033[00;35m$1\033[0m\n"
}

success() {
  printf "\r\033[00;32m$1\033[0m\n"
}
fail() {
  printf "\r\033[0;31m$1\033[0m\n"
}
divider() {
  printf "\r\033[0;1m========================================================================\033[0m\n"
}

pause_for_confirmation() {
  read -rsp $'Press any key to continue (ctrl-c to quit):\n' -n1 key
}

echoes_and_sleep_timer() {
  echo
  echo "..."
  sleep $1
  echo
  echo
}

# Set up an interrupt handler so we can exit gracefully
interrupt_count=0
interrupt_handler() {
  ((interrupt_count += 1))

  echo ""
  if [[ $interrupt_count -eq 1 ]]; then
    fail "Really quit? Hit ctrl-c again to confirm."
  else
    echo "Goodbye!"
    exit
  fi
}
trap interrupt_handler SIGINT SIGTERM

# Running the terraform init, terraform plan, and terraform apply
terraform_run() {
  TF_PARAMS=$1
  PHASE=$2
  echoes_and_sleep_timer 1
  info "Step 1:"
  echo "$ terraform $TF_PARAMS"
  terraform $TF_PARAMS
  echoes_and_sleep_timer 2
  success "You're entering the second step."
  info "Step 2:"
  echo "$ terraform plan"
  terraform plan
  echoes_and_sleep_timer 2
  success "The final step of the $PHASE phase."
  info "Step 3:"
  echo "$ terraform apply -auto-approve"
  terraform apply -auto-approve
  echoes_and_sleep_timer 2
  success "The $PHASE phase is complete!"
  echo
  echo 
}

# Check for required tools
declare -a req_tools=("terraform" "sed" "jq")
for tool in "${req_tools[@]}"; do
  if ! command -v "$tool" > /dev/null; then
    fail "It looks like '${tool}' is not installed; please install it and run this setup script again."
    exit 1
  fi
done

# Get the minimum required version of Terraform
minTerraformMajorVersion=0
minTerraformMinorVersion=14
minTerraformVersion=$(($minTerraformMajorVersion * 1000 + $minTerraformMinorVersion))

# Get the current version of Terraform
installedTerraformMajorVersion=$(terraform version -json | jq -r '.terraform_version' | cut -d '.' -f 1)
installedTerraformMinorVersion=$(terraform version -json | jq -r '.terraform_version' | cut -d '.' -f 2)
installedTerraformVersion=$(($installedTerraformMajorVersion * 1000 + $installedTerraformMinorVersion))

# Check we meet the minimum required version
if [ $installedTerraformVersion -lt $minTerraformVersion ]; then
  echo
  fail "Terraform $minTerraformMajorVersion.$minTerraformMinorVersion.x or later is required for this setup script!"
  echo "You are currently running:"
  terraform version
  exit 1
fi

# Check if AWS credentials and config files is available
CONFIG_FILE="$HOME/.aws/config"
CREDENTIALS_FILE="$HOME/.aws/credentials"
# TOKEN=$(jq -j --arg h "$HOST" '.credentials[$h].token' "$CREDENTIALS_FILE")
if [[ ! -f $CREDENTIALS_FILE || ! -f $CONFIG_FILE ]]; then
  fail "\nError: We couldn't find AWS credentials and config files from the path below."
  printf "Credentials: $CREDENTIALS_FILE \n"
  printf "Config: $CONFIG_FILE \n\n"
  printf "Create an AWS IAM account with these priviledges \n\r"
  info "AdministratorAccess\n\n"
  printf "Please visit https://aws.amazon.com/iam/ for more information\n\r"
  printf "and run 'aws configure' command, then run this setup script again.\n\n"
  success "If you use other method for authentication.."
  pause_for_confirmation
  echo
fi

# Set up some variables we'll need
TF_BACKEND="backend.tf"
TF_BACKEND_S3="backend-s3.tf"
BACKEND_TF=$(dirname ${BASH_SOURCE[0]})/${TF_BACKEND}
TEMP=$(mktemp)
TERRAFORM_VERSION=$(terraform version -json | jq -r '.terraform_version')
BACKEND_BLOCK='backend "s3" { \
    # Must be the same value with the aws_s3_bucket name \
    bucket         = "yourappname-tf-state-v1" # bug: it has to provision it first \
    key            = "yourappname\/terraform.tfstate" \
    region         = "us-west-1" \
    encrypt        = true \
    dynamodb_table = "yourappname-tf-state-locking" # Must be the same value with aws_dynamodb_table name \
    # profile        = "your-iam-profile" \
    # shared_credentials_file = "$HOME\/.aws\/credentials" \
  } \
'

# Check that this is your first time running this script. If not, we'll reset
# all local state and restart from scratch!
# Simulating you had this script run already
# git add -A
  # git reset --mixed HEAD

if ! git diff-index --quiet --no-ext-diff HEAD -- $TF_BACKEND $TF_BACKEND_S3; then
  echo "It looks like you may have run this script before! Backup \".copy\" file will be automatically generated for safety."
  echo
  echo "Re-running it will reset any changes you've made to $TF_BACKEND and $TF_BACKEND_S3."
  echo
  pause_for_confirmation
  # Creating a backup file
  cp $TF_BACKEND "$TF_BACKEND.copy"
  cp $TF_BACKEND_S3 "$TF_BACKEND_S3.copy"
  # Restoring from the git chached
  git checkout HEAD -- $TF_BACKEND $TF_BACKEND_S3
  # rm -rf .terraform
  rm -f .terraform/terraform.tfstate
  rm -f *.lock.hcl
  rm -f errored.tfstate
fi

echo
printf "\r\033[00;35;1m
--------------------------------------------------------------------------
We are now running the terraform commands
-------------------------------------------------------------------------\033[0m"

# Find and replace "yourappname" string to your nominated app name
cat $TF_BACKEND_S3 | sed "s/yourappname/$APP_NAME/g" > $TEMP
mv $TEMP $TF_BACKEND_S3
echo

info "\n\n\nThe first phase is initializing.."
# Initialize the working directory, 
# don’t hold a state lock during backend migration.
terraform_run "init" "First"

info "Entering into the second phase.."
cat $TF_BACKEND | sed "s/##BACKEND_BLOCK##/$BACKEND_BLOCK/" | \
sed "s/yourappname/$APP_NAME/" > $TEMP
mv $TEMP $TF_BACKEND 

# Running the terraform commands
terraform_run "init -migrate-state -force-copy" "Second"

END=$(date +%s)
DIFF=$(( $END - $START ))
divider
success "\n\nCongratulations! It took $DIFF seconds to comple. \n\n"
divider
info "\n\nDon't forget to destroy it if it is not in use."
info "\n\nJust copy and run this whole command below"
echo "$ git checkout HEAD -- $TF_BACKEND && \
terraform init -migrate-state -force-copy && \
terraform destroy -auto-approve && \
echo \"# edited\" >> ./$TF_BACKEND"
echo
echo
exit 0