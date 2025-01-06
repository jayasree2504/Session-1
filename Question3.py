def product_and_sum(multiplier, addend):
    # Multiply two numbers and add the second number to the result
    product = multiplier * addend
    return product + addend

def sum_and_extended_result(num1, num2):
    # Compute the sum of two numbers and their extended result
    total_sum = num1 + num2
    extended_result = product_and_sum(num1, num2)
    return total_sum, extended_result

