#!/bin/bash

# Check if the output file path is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <output_file>"
    exit 1
fi

# Use the provided argument as the output file path
output_file="$1"

# Execute the passwd -S command
passwd_status=$(passwd -S)

# Extract fields from the passwd -S output
username=$(echo $passwd_status | awk '{print $1}')
password_status=$(echo $passwd_status | awk '{print $2}')
last_change=$(echo $passwd_status | awk '{print $3}')
min_days=$(echo $passwd_status | awk '{print $4}')
max_days=$(echo $passwd_status | awk '{print $5}')
warn_days=$(echo $passwd_status | awk '{print $6}')

# Write the detailed explanation to the output file
cat << EOF > $output_file
The result of the "passwd -S" command is as follows:

$passwd_status

Explanation of each field:

1. Username: $username
   - This is the account name of the user.

2. Password Status: $password_status
   - This indicates the current status of the user's password.
   - 'P' means the password is usable.
   - 'L' means the account is locked.
   - 'NP' means there is no password set for the account.
   - 'NL' means no login (account is locked).

3. Last Password Change: $last_change
   - This is the date when the password was last changed.
   - The format is MM/DD/YYYY.

4. Minimum Password Age (days): $min_days
   - This is the minimum number of days required between password changes.
   - This prevents the user from changing their password too frequently.

5. Maximum Password Age (days): $max_days
   - This is the maximum number of days the password is valid.
   - After this period, the user must change their password.
   - A value of -1 means that there is no maximum password age set, so the password does not expire.

6. Password Warning Period (days): $warn_days
   - This is the number of days before the password expires that the user is warned to change their password.

EOF

# Display a message indicating the script has finished
echo "Password status and explanations have been written to $output_file."