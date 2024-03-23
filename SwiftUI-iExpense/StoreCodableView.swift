//
//  StoreCodableView.swift
//  SwiftUI-iExpense
//
//  Created by JimmyChao on 2024/3/23.
//

import SwiftUI
import Foundation

struct UserInfo: Codable  {
    var firstName: String
    var lastName: String
}

struct StoreCodableView: View {
    
    @State private var userInfo = UserInfo(firstName: "", lastName: "")
    @State private var retreivedInfo: UserInfo?
    
    var body: some View {
        List {
            Section("User input") {
                TextField(
                    "Please enter your first name",
                    text: $userInfo.firstName)
                
                TextField(
                    "Please enter your last name",
                    text: $userInfo.lastName)
            }
            
            Section("Action") {
                Button("Save user") {
                    if let data = try? JSONEncoder().encode(userInfo) {
                        UserDefaults.standard.setValue(data, forKey: "userInfo")
                    }
                }
                
                Button("Read from user") {
                    if let data = UserDefaults.standard.data(forKey: "userInfo"), 
                        let response = try? JSONDecoder().decode(UserInfo.self, from: data) {
                        retreivedInfo = response
                    }
                }
            }
            
            Section("Result") {
                Text("My name is \(retreivedInfo?.firstName ?? "") \(retreivedInfo?.lastName ?? "")")
            }
        }
        
    }
}

#Preview {
    StoreCodableView()
}
