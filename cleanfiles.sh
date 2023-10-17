#to clean files from terragrunt cache
remove_list=".terraform *.out .terragrunt-cache .terraform.lock.hcl terragrunt"

for item in $remove_list; do
  find . -type d -name "$item" -exec rm -rf {} \;
  find . -type f -name "$item" -exec rm -f {} \;
done