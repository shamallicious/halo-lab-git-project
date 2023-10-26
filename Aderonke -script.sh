#!/bin/bash

# Set the initial account balance
account_balance=1000

# Function to display the account balance
function display_balance() {
  echo "Your account balance is $account_balance naira."
}

# Function to withdraw cash
function withdraw_cash() {
  local amount="$1"
  
  if ((amount <= 0)); then
    echo "Invalid amount. Please enter a positive amount."
  elif ((amount > account_balance)); then
    echo "Insufficient funds. Your account balance is $account_balance naira."
  else
    account_balance=$((account_balance - amount))
    echo "Withdrawn $amount naira. Your new balance is $account_balance naira."
  fi
}

# Main loop
while true; do
  echo "1. Display Balance"
  echo "2. Withdraw Cash"
