//
//  ContentView.swift
//  SwiftUI-iExpense
//
//  Created by JimmyChao on 2024/3/23.
//

import SwiftUI
import Foundation
import Observation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

enum TypeCategories: String {
    case Personal
    case Business
}

@Observable
class Expenses {
    
    init() {
        if let savedData = UserDefaults.standard.data(forKey: "items"),
           let response = try? JSONDecoder().decode([ExpenseItem].self, from: savedData) {
            items = response
            return
        }
    }
    
    var items: [ExpenseItem] = [] {
        didSet {
            if let dataToBeSaved = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(dataToBeSaved, forKey: "items")
            }
        }
    }
}

struct ContentView: View {
    
    @State private var showAddView = false
    let expenses = Expenses()
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    // Formatter
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        formatter.groupingSeparator = "."
        formatter.usesGroupingSeparator = true
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            List {
                
                Section("Personal") {
                    showList(by: .Personal)
                }
                
                Section("Business") {
                    showList(by: .Business)
                }
                
            }
            .frame(width: 400)
            .listStyle(PlainListStyle())
            .navigationTitle("Awesome Sauce")
            .toolbar {
                
                EditButton()
                
                NavigationLink("add") {
                    AddView(expenses: expenses)
                }
            }
        }
    }
    // Return list of view according to category
    func showList(by type: TypeCategories) -> some View {
        return ForEach(expenses.items) { item in
            if type.rawValue == item.type {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(item.name)")
                        Text("\(item.type)")
                    }
                    Spacer()
                    Text("\(item.amount.formatted()) \(currencyCode)")
                }
                .listRowInsets(.init(
                    top: 10,
                    leading: 15,
                    bottom: 10,
                    trailing: 15))
                .padding(20)
                .background(switchBGcolor(by: item.amount))
                .clipShape(.rect(cornerRadius: 20))
            }
        }.onDelete { indexSet in
            
            let idsToDelete = indexSet.map { index in
                expenses.items[index].id
            }
            idsToDelete.forEach { id in
                expenses.items.removeAll { item in
                    item.id == id
                }
            }
        }
    }
    
    // Helper functions
    func switchBGcolor(by amount: Double) -> Color {
        switch amount {
        case _ where amount <= 10 :
            return Color.red
        case _ where amount >= 11 && amount <= 100:
            return Color.blue
        default: return Color.green
        }
    }
}

#Preview {
    ContentView()
}
