//
//  PracticeWithSheet.swift
//  SwiftUI-iExpense
//
//  Created by JimmyChao on 2024/3/23.
//

import SwiftUI

struct SecondView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let name: String
    var body: some View {
        VStack {
            Text("Hello, my name is \(name)")
            Button("Dismiss") {
                dismiss()
            }
        }
    }
}

struct PracticeWithSheet: View {
    
    @State private var isSheetShowing = false
    
    var body: some View {
        Button("Show sheet") {
            isSheetShowing.toggle()
        }.sheet(isPresented: $isSheetShowing) {
            SecondView(name: "Jimmy")
        }
    }
}

#Preview {
    PracticeWithSheet()
}
