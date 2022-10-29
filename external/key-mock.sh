#!/bin/bash

# Set secrets via environment variables
export TF_VAR_auth_accesskey="your-access-key-id"
export TF_VAR_auth_secretkey="your-secret-key-id"

# Set mysql db password in rds instance
export TF_VAR_mysql_psswd="your-password"