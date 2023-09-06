#!/bin/bash

TOTAL_BALANCE=5000

echo "Welcome to our bank. Kindly pick an option:"
read -p """
      What will you perform today?
      1. Withdraw cash
      2. Deposit cash
      3. Check balance
      Input select: """ choice

withdraw_cash(){
    read -p "How much are you withdrawing(in USDT)? $" WITHDRAW_AMOUNT
    if [[ "$WITHDRAW_AMOUNT" =~ ^[0-9]+$ && "$WITHDRAW_AMOUNT" -le "$TOTAL_BALANCE" ]]; then
        echo "Withdrawing $WITHDRAW_AMOUNT cash..."
        sleep 10s
        NEW_BALANCE=$((TOTAL_BALANCE-WITHDRAW_AMOUNT))
        echo "Your new balance is $NEW_BALANCE."
    else
        echo "Invalid input. Please enter a valid amount (numeric and less than or equal to the total balance)."
    fi 
}

deposit_cash(){
    read -p "How much are you depositing? " DEPOSIT_AMOUNT
    if [[ "$DEPOSIT_AMOUNT" =~ ^[0-9]+$ && "$DEPOSIT_AMOUNT" -gt 0 ]]; then
        echo "Depositing $DEPOSIT_AMOUNT cash..."
        TOTAL_BALANCE=$((TOTAL_BALANCE+DEPOSIT_AMOUNT))
        echo "Your new balance is $TOTAL_BALANCE."
    else
        echo "Invalid input. Please enter a valid amount (numeric and greater than 0)."
    fi 
}

check_balance(){
    echo "Your current balance is $TOTAL_BALANCE."
}

case $choice in
    1) withdraw_cash ;;
    2) deposit_cash ;;
    3) check_balance ;;
    *) echo "Invalid option"; exit 1 ;;
esac
