//
//  AddView.swift
//  SwiftUI-iExpense
//
//  Created by JimmyChao on 2024/3/24.
//

import SwiftUI

struct AddView: View {
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @Environment(\.dismiss) var dismiss
    
    let types = ["Business", "Personal"]
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    var expenses: Expenses
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Enter the name", text: $name)
                
                Picker("Select a type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text("\($0)")
                    }
                }
                
                TextField("Enter the amount", value: $amount, format: .currency(code: currencyCode))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save", systemImage: "square.and.arrow.down") {
                    let item = ExpenseItem(
                        name: name,
                        type: type,
                        amount: amount)
                    expenses.items.append(item)
                    
                    dismiss()
                }
            }
        }
    }
}
