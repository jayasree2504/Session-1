#include <iostream>
#include <map>
#include <string>
#include <iomanip>

using namespace std;

class OrderService {
private:
    map<string, pair<int, double>> inventory; // Stores items -> <quantity, price>
    const double TAX_RATE = 0.10; // 10% tax
    const double DISCOUNT_THRESHOLD = 100.0; // Discount applies if total > $100
    const double DISCOUNT_RATE = 0.05; // 5% discount

public:
    OrderService() {
        // Initialize inventory with some items
        inventory = {
            {"item1", {10, 20.0}},
            {"item2", {5, 50.0}},
            {"item3", {8, 30.0}}
        };
    }

    // Display the available inventory to the user
    void showInventory() {
        cout << "\nAvailable Inventory:\n";
        cout << left << setw(15) << "Item" << setw(10) << "Quantity" << setw(10) << "Price\n";
        for (const auto& [item, details] : inventory) {
            cout << left << setw(15) << item << setw(10) << details.first << setw(10) << fixed << setprecision(2) << details.second << "\n";
        }
    }

    // Check if the requested items and quantities are valid
    bool validateOrder(const map<string, int>& order) {
        for (const auto& [item, quantity] : order) {
            // Check if item exists in inventory
            if (inventory.find(item) == inventory.end()) {
                cout << "Error: Item '" << item << "' is not in stock.\n";
                return false;
            }
            // Check if quantity is available
            if (inventory[item].first < quantity) {
                cout << "Error: Not enough stock for '" << item << "'. Available: " << inventory[item].first << "\n";
                return false;
            }
        }
        return true;
    }

    // Calculate total price, tax, and discount for the order
    double calculateTotal(const map<string, int>& order, double& tax, double& discount) {
        double subtotal = 0.0;

        // Calculate subtotal for the order
        for (const auto& [item, quantity] : order) {
            subtotal += inventory[item].second * quantity;
        }

        // Calculate tax and discount
        tax = subtotal * TAX_RATE;
        discount = (subtotal > DISCOUNT_THRESHOLD) ? subtotal * DISCOUNT_RATE : 0.0;

        return subtotal + tax - discount;
    }

    // Process the order: validate, update inventory, and generate receipt
    void processOrder(const map<string, int>& order) {
        if (!validateOrder(order)) {
            return; // Stop processing if validation fails
        }

        // Deduct ordered quantities from inventory
        for (const auto& [item, quantity] : order) {
            inventory[item].first -= quantity;
        }

        // Calculate total, tax, and discount
        double tax = 0.0, discount = 0.0;
        double finalTotal = calculateTotal(order, tax, discount);

        // Generate receipt for the user
        printReceipt(order, tax, discount, finalTotal);
    }

    // Print the receipt for the user
    void printReceipt(const map<string, int>& order, double tax, double discount, double total) {
        cout << "\n---- Receipt ----\n";
        cout << left << setw(15) << "Item" << setw(10) << "Quantity" << setw(10) << "Price\n";

        for (const auto& [item, quantity] : order) {
            cout << left << setw(15) << item << setw(10) << quantity << setw(10) << inventory[item].second * quantity << "\n";
        }

        cout << "-----------------\n";
        cout << "Tax: $" << fixed << setprecision(2) << tax << "\n";
        cout << "Discount: $" << fixed << setprecision(2) << discount << "\n";
        cout << "Total: $" << fixed << setprecision(2) << total << "\n";
        cout << "-----------------\n";
    }
};

int main() {
    OrderService orderService;

    cout << "Welcome to the Order Processing System!\n";

    while (true) {
        // Display the inventory to the user
        orderService.showInventory();

        // Create an order
        map<string, int> order;
        string item;
        int quantity;

        cout << "\nEnter items for your order (type 'done' when finished):\n";
        while (true) {
            cout << "Enter item name: ";
            cin >> item;

            if (item == "done") {
                break; // Exit the loop when user is done
            }

            cout << "Enter quantity: ";
            cin >> quantity;

            order[item] += quantity; // Add item and quantity to the order
        }

        // Process the order
        orderService.processOrder(order);

        // Ask the user if they want to place another order
        string choice;
        cout << "\nDo you want to place another order? (yes/no): ";
        cin >> choice;
        if (choice != "yes") {
            break;
        }
    }

    cout << "\nThank you for using the Order Processing System!\n";
    return 0;
}
