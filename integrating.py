import unittest
from service import final_price

class TestFinalPriceIntegration(unittest.TestCase):
    def test_basic_final_price(self):
        self.assertEqual(final_price(100, 10), 90)  # 100 - 10% of 100
        self.assertEqual(final_price(200, 20), 160)  # 200 - 20% of 200

    def test_edge_cases(self):
        self.assertEqual(final_price(100, 0), 100)  # No discount
        self.assertEqual(final_price(100, 100), 0)  # Full discount
        self.assertEqual(final_price(0, 10), 0)  # No price

    def test_negative_values(self):
        self.assertEqual(final_price(-100, 10), -90)  # Negative price
        self.assertEqual(final_price(100, -10), 110)  # Negative discount increases price

if __name__ == '__main__':
    unittest.main()
