def calculate_discount(price, discount_percentage):
    """Calculates the discount amount."""
    return price * (discount_percentage / 100)
def final_price(price, discount_percentage):
    """Calculates the final price after discount."""
    discount = calculate_discount(price, discount_percentage)
    return price - discount
