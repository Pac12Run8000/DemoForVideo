import SwiftUI
//import FirebaseAnalytics

struct ShoppingCartView: View {
    let availableItems: [Item] = [
        Item(name: "boxing gloves", price: 150.00),
        Item(name: "mouth guard", price: 12.00),
        Item(name: "headgear", price: 75.00),
        Item(name: "handwraps", price: 10.00)
    ]
    
    @State private var cartItems: [Item] = []
    @State private var showCheckoutAlert: Bool = false
    @State private var checkoutMessage: String = ""
    
    var totalCost: Double {
        cartItems.reduce(0) { total, item in
            total + item.price
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Available Items")) {
                    ForEach(availableItems) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(String(format: "%.2f", item.price))")
                            
                            Button(action: {
                                if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
//                                    Analytics.logEvent("remove_item", parameters: ["item": cartItems[index].name])
                                    cartItems.remove(at: index)
                                    
                                    
                                } else {
                                    cartItems.append(item)
//                                    Analytics.logEvent("add_item", parameters: ["item": item.name])
                                }
                            }) {
                                Image(systemName: cartItems.contains(where: { $0.id == item.id }) ? "minus.circle" : "plus.circle")
                                    .foregroundColor(cartItems.contains(where: { $0.id == item.id }) ? .red : .green)
                            }
                        }
                    }
                }
                
                Section(header: Text("Items in Cart")) {
                    ForEach(cartItems) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(String(format: "%.2f", item.price))")
                        }
                    }
                    
                    HStack {
                        Text("Total")
                            .fontWeight(.bold)
                        Spacer()
                        Text("$\(String(format: "%.2f", totalCost))")
                            .fontWeight(.bold)
                    }
                }
                Button(action: {
//                    let itemListString = generateCommaDelimitedItemNames(from: cartItems)
//                    logPurchaseConfirmedEvent(totalAmount: totalCost, itemList: itemListString, itemCount: cartItems.count)
                                        checkoutMessage = "Transaction confirmed"
                                        showCheckoutAlert = true
                                    }) {
                                        Text("Checkout")
                                            .foregroundColor(.white)
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(Color.blue)
                                            .cornerRadius(8)
                                    }
                                    .alert(isPresented: $showCheckoutAlert) {
                                                    Alert(title: Text("Checkout"), message: Text(checkoutMessage), dismissButton: .default(Text("OK")))
                                                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Shopping Cart", displayMode: .inline)
        }
    }
    /*
    func generateCommaDelimitedItemNames(from itemList: [Item]) -> String {
        let itemNames = itemList.map { $0.name }
        let commaDelimitedNames = itemNames.joined(separator: ", ")
        return commaDelimitedNames
    }
    
    func logPurchaseConfirmedEvent(totalAmount: Double, itemList: String, itemCount: Int) {
        Analytics.logEvent("purchase_confirmed", parameters: [
            "total_amount": NSNumber(value: totalAmount),
            "item_list": itemList as NSString,
            "item_count": NSNumber(value: itemCount)
        ])
    }
     */

}


struct Item: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
}



struct ShoppingCart_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView()
    }
}

