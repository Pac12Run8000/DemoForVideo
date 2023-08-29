import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Text("Home")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            ShoppingCartView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Shopping Cart")
                }
            
            Text("Latest News")
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("Latest News")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}


