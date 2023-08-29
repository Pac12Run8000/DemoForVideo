
import SwiftUI

struct LoginPageView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var showPassword: Bool = false
    @State private var navigateToMain: Bool = false
        
        // Create an instance of LoginManager
        private let loginManager = LoginManager()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .textContentType(.username)
                    .autocapitalization(.none)
                
                HStack {
                    if showPassword {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                    
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
                
                
                Button(action: {
                    // Handle login action here
                    print("Login button tapped!")
                    if loginManager.validate(username: username, password: password) {
                        print("Login successful!")
                        navigateToMain = true
                    } else {
                        showAlert = true
                    }
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Invalid username or password"), dismissButton: .default(Text("OK")))
                }
                NavigationLink("", destination: MainTabView(), isActive: $navigateToMain)
                                   .hidden()
                
                Spacer()
            }
            .padding(.top, 50)
            
        }
        
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}

