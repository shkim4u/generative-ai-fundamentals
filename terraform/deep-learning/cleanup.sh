#!/bin/bash

# Remove role from the instance profile.
aws iam remove-role-from-instance-profile --instance-profile-name alamini-admin-instance-profile --role-name dlami-admin

# Delete instance profile.
aws iam delete-instance-profile --instance-profile-name dlami-admin-instance-profile

# List the attached policies.
aws iam list-attached-role-policies --role-name dlami-admin

# Detach the all attached policies from the role.
aws iam detach-role-policy --role-name dlami-admin --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

# Finally, delete the role.
aws iam delete-role --role-name dlami-admin


aws iam remove-role-from-instance-profile --instance-profile-name dlami-admin-instance-profile --role-name dlami-admin