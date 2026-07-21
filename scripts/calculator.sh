#!/bin/bash

read -p "Enter first number: " num1
read -p "Enter second number: " num2

echo "Choose operation:"
echo "1. Addition"
echo "2. Subtraction"
echo "3. Multiplication"
echo "4. Division"

read -p "Enter choice (1-4): " choice

case $choice in
1)
    echo "Result = $((num1 + num2))"
    ;;
2)
    echo "Result = $((num1 - num2))"
    ;;
3)
    echo "Result = $((num1 * num2))"
    ;;
4)
    if [ "$num2" -eq 0 ]; then
        echo "Error: Division by zero is not allowed."
    else
        echo "Result = $((num1 / num2))"
    fi
    ;;
*)
    echo "Invalid choice."
    ;;
esac
