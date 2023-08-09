#!/bin/bash
TIMELIMIT=500
atmpin=1234
Balance= 50000
newbalance=




echo "PLEASE INSERT CARD"

echo "WELCOME TO HALOLAB CASH DISPENSER"

# sleep command lets the terminal wait by the specified amount of time which in this case is 5secs
sleep 5

echo " Loading...."

echo "PLEASE TYPE YOUR PIN"

read pin

echo "Loading..."
sleep 3

if [[ $pin != $atmpin ]];
then
echo "INVALIDE PASSWORD! PLEASE TRY AGAIN"
sleep 3
fi


while [[ $pin -eq atmpin ]];

do

echo "HELLO FROM HALOLAB CASH DISPENSER"
echo "Press 1 for Withdraw Money"
echo "Press 2 for Balance Checking"
echo "Press 3 for Logout"
echo "Please Press Your Service:"

read $service in 
1)
echo "WITHDRAW MONEY"

echo -e "AMOUNT: "

read WithdrawAmount

$newbalance = "$Balance -= $WithdrawAmount | bc-1"

if [ $WithdrawAmount -lt $Balance ]; then

echo "Transcation successful"

else 
echo "Insufficent balance"

fi
;;

2)
echo "YOU HAVE $newbalance" LEFT IN YOUR ACCOUNT"
;;


3)
echo "THANK YOU FOR USING OUR SERVICE"
;;
break

*)
echo "THAT IS AN INVALID CHOICE, TRY 1 OR 2"
;;

   
esac
done




