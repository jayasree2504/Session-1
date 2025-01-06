import unittest
from service import calculate_discount

class TestCalculateDiscount(unittest.TestCase):
    def test_basic_discounts(self):
        self.assertEqual(calculate_discount(100, 10), 10)  # 10% of 100
        self.assertEqual(calculate_discount(200, 20), 40)  # 20% of 200

    def test_zero_and_full_discounts(self):
        self.assertEqual(calculate_discount(100, 0), 0)  # No discount
        self.assertEqual(calculate_discount(100, 100), 100)  # Full discount

    def test_negative_values(self):
        self.assertEqual(calculate_discount(-100, 10), -10)  # Negative price
        self.assertEqual(calculate_discount(100, -10), -10)  # Negative discount

if __name__ == '__main__':
    unittest.main()
