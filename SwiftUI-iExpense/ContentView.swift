//
//  ContentView.swift
//  SwiftUI-iExpense
//
//  Created by JimmyChao on 2024/3/23.
//

import SwiftUI
import Foundation
import Observation

@Observable class User {
    var firstName: String = ""
    var lastName: String = ""
}

struct ContentView: View {
    
    @State private var user = User()
    
    var body: some View {
        VStack {
            
            List {
                TextField("Please enter your firstname", text: $user.firstName)
                TextField("Please enter your lastname", text: $user.lastName)
                
                Section {
                    Text(
                        """
                        Your first name is \(user.firstName)
                        and last name is \(user.lastName)
                        """
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
