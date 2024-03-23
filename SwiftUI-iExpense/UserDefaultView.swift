//
//  UserDefaultPracticeView.swift
//  SwiftUI-iExpense
//
//  Created by JimmyChao on 2024/3/23.
//

import SwiftUI

struct UserDefaultView: View {
    
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        Button("Tap count \(tapCount)") {
            tapCount += 1
            
            UserDefaults.standard.setValue(
                tapCount,
                forKey: "Tap")
        }
    }
}

#Preview {
    UserDefaultView()
}
