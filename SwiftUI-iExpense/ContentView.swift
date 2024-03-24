//
//  ContentView.swift
//  SwiftUI-iExpense
//
//  Created by JimmyChao on 2024/3/23.
//

import SwiftUI
import Foundation
import Observation

struct ExpenseItem: Identifiable {
    var id = UUID()
    var name: String
    var type: String
    var amount: Int
}

@Observable
class Expenses {
    var item: [ExpenseItem] = []
}

struct ContentView: View {
    
    let expenses = Expenses()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.item) { item in
                    VStack {
                        Text("\(item.name)")
                        Text("\(item.amount)")
                        Text("\(item.type)")
                    }
                }.onDelete {
                    expenses.item.remove(atOffsets: $0)
                }
            }
            .navigationTitle("Awesome Sauce")
            .toolbar {
                Button("add", systemImage: "plus") {
                    let expenseItem = ExpenseItem(name: "Eggs", type: "Food", amount: 65)
                    withAnimation {
                        expenses.item.append(expenseItem)
                    }
                }
            }
            
            
        }
    }
}

#Preview {
    ContentView()
}
