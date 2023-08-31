#!/bin/bash

# Create a model Cash Dispenser using only Bash script. 

# Features
##Get user name
## Get user card details. - Card Number and Card CVV
##Get user withdrawal amount
##Script must have proper error handling
##Should simulate a real-world cash dispenser as closely as possible

MENU_CHOICE=""
ACCOUNT_BALANCE=""
STRIPPED_CARD_NUMBER=""
WITHDRAWAL_AMOUNT=""
DAILY_WITHDRAWAL_LIMIT=100000
LIMIT_PER_TRANSACTION=40000
DAILY_CUMULULATIVE_WITHDRAWAL=""
DENOM_ARR=(0 500)

#generate random account balance between 2000 and 200000
function generate_random_account_balance() {
  ACCOUNT_BALANCE="$[ ($RANDOM % 100 + 1) * 2000 ]"
}

#generate account balance
generate_random_account_balance

#Welcome Message
function welcome_user() {
  echo -e "Welcome to CNC Bank \n"
  echo -e "Please enter your 16 digit Card number in the format shown below\n
  - '5*** **** **** ****' for Mastercard\n
  - '4*** **** **** ****' for Visa \n"

  read -p "Enter Card Number please..: " -n16 -e -t 20 CARD_NUMBER
}

function display_account_balance() {
  echo -e "\nRetrieving Account Balance.."
  
  echo -e "\nYour account balance is ₦$ACCOUNT_BALANCE.00\n"
  read -p "Press any key to continue: " -e MENU_CHOICE
  set_menu_option
  menu_processor
}

function make_withdrawal() {
  echo $ACCOUNT_BALANCE
  echo -e "\n-This Machine only dispenses ₦1000 and ₦500 notes, please ensure that your withdrawal amount is in multiples of these denominations.\n
  \n-You can only withdraw ₦$LIMIT_PER_TRANSACTION.00 per transactions.\n
  \n-Daily withdraw limit of ₦$DAILY_WITHDRAWAL_LIMIT.00 applys to all account.\n"
  read -p "Enter the amount you wish to withdraw: " -e WITHDRAWAL_AMOUNT

  #Verify that withdrawal amount is not greater than amount per transaction
  if [ $(($WITHDRAWAL_AMOUNT)) -ge $LIMIT_PER_TRANSACTION ]
    then
      echo -e "\nTRANSACTION FAILED!\n"
      echo -e "You can only withdraw a maximum of $LIMIT_PER_TRANSACTION per transaction."
      set_menu_option
      menu_processor
  fi

  #Verify that daily withdrawal limit has not been reached
  if [ $(($DAILY_CUMULULATIVE_WITHDRAWAL)) -ge $DAILY_WITHDRAWAL_LIMIT ]
    then
      echo -e "\nTRANSACTION FAILED!\n"
      echo -e "The daily withdrawal limit of $DAILY_WITHDRAWAL_LIMIT has been reached."
      set_menu_option
      menu_processor
  fi

  #Verify that withdrawal amount is at least equal to the account balance
  if [ $(($ACCOUNT_BALANCE-$WITHDRAWAL_AMOUNT)) -le 0 ]
    then
      echo -e "\nTRANSACTION FAILED!\n"
      echo -e "Insufficient Balance"
      set_menu_option
      menu_processor
  fi

  #Check that withdrawal amount is a multiple of 1000 or 500
  if ! [[ " ${DENOM_ARR[*]} " =~ $(($WITHDRAWAL_AMOUNT % 1000)) ]]
    then
      echo -e "\nTRANSACTION FAILED!\n"
      echo -e "Withdrawal amount ₦$WITHDRAWAL_AMOUNT.00 is not a multiple of ₦1000.00 or ₦500.00"
      set_menu_option
      menu_processor
  fi

  #Update Account Balance
  ACCOUNT_BALANCE=$(($ACCOUNT_BALANCE-$WITHDRAWAL_AMOUNT))

  #Update daily cumulative transaction value
  DAILY_CUMULULATIVE_WITHDRAWAL=$(($DAILY_CUMULULATIVE_WITHDRAWAL+$WITHDRAWAL_AMOUNT))

  echo -e "\nPlease take your cash!"
  read -p "Enter any key to continue: " -e MENU_CHOICE
  set_menu_option
  menu_processor
}

function menu_processor() {
  case "$MENU_CHOICE" in
    [yY])
      welcome_user
      ;;
    [nN9])
      echo -e "\nThank you for banking with us\n"
      exit 0
      ;;
    [0])
      set_menu_option
      ;;
    [1])
      display_account_balance
      ;;
    [2])
      make_withdrawal
      ;; 
    *)
      echo -e "\nYour selection is invalid\n"
      ;;
  esac
}

function set_menu_option() {
  echo -e "
  \n- Enter 1 to check you Account Balance.\n
  \n- Enter 2 to make withdrawal.\n
  \n- Enter 9 to quit.\n"
  read -p "Enter your selection: " -e MENU_CHOICE
}


#Welcome user and get card details
welcome_user

while true
do
  STRIPPED_CARD_NUMBER="$(echo -e "${CARD_NUMBER}" | tr -d '[:space:]')"
  if [[ $STRIPPED_CARD_NUMBER =~ ^[4|5]+[0-9]+$ ]] && [[ ${#STRIPPED_CARD_NUMBER}==16 ]];
  then
    set_menu_option
    menu_processor
  else
    echo -e "\nYou have entered an invalid Card Number!\n"
    read -p "Any key to continue or N to quit: " MENU_CHOICE
    if ! [[ $MENU_CHOICE =~  [n,N] ]];
    then
      welcome_user
    fi
    menu_processor
  fi
done
