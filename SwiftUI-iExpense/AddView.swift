//
//  AddView.swift
//  SwiftUI-iExpense
//
//  Created by JimmyChao on 2024/3/24.
//

import SwiftUI

struct AddView: View {
    
    @State private var name = "Add new expense"
    @State private var type = "Personal"
    @State private var amount = 0.0
    @Environment(\.dismiss) var dismiss
    
    let types = ["Business", "Personal"]
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    var expenses: Expenses
    
    // Formatter
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = "."
        formatter.usesGroupingSeparator = true
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            Form {
                
                Picker("Select a type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text("\($0)")
                    }
                }
                
                TextField("Enter the amount", value: $amount, formatter: currencyFormatter)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
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
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}
