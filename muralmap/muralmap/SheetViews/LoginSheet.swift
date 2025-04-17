//
//  LoginSheet.swift
//  muralmap
//
//  Created by Austin Hargis on 3/25/25.
//

import SwiftUI

struct LoginSheet: View {
    @Binding var showLoginSheet: Bool
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                Form {
                    TextField(text: $email, prompt: Text("Required")) {
                        Text("Email")
                    }
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    
                    SecureField(text: $password, prompt: Text("Required")) {
                        Text("Password")
                    }
                    .textContentType(.password)
                }
                
            }
            
        }
        .navigationTitle("Login")
    }
}

#Preview {
    @Previewable @State var showLoginSheet: Bool = true
    NavigationStack {
        LoginSheet(showLoginSheet: $showLoginSheet)
    }
}
