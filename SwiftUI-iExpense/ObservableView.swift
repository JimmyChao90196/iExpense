//
//  ObservableView.swift
//  SwiftUI-iExpense
//
//  Created by JimmyChao on 2024/3/24.
//

import SwiftUI

@Observable class User {
    var firstName: String = ""
    var lastName: String = ""
}

struct ObservableView: View {
    
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
    ObservableView()
}
