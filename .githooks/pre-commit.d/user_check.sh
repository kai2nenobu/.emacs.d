#!/bin/sh

###
### Check user.name and user.email are valid
###

# Redirect output to stderr.
exec 1>&2

name=$(git config user.name)
email=$(git config user.email)

if [ "$name" != 'Tsunenobu Kai' ]; then
  echo "user.name is invalid: $name"
  exit 1
fi

if [ "$email" != 'kai2nenobu@gmail.com' ]; then
  echo "user.email is invalid: $email"
  exit 1
fi
