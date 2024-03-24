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
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(item.name)")
                            Text("\(item.type)")
                        }
                        Spacer()
                        Text("\(item.amount)")
                    }
                }.onDelete {
                    expenses.items.remove(atOffsets: $0)
                }
            }
            .navigationTitle("Awesome Sauce")
            .toolbar {
                Button("add", systemImage: "plus") {
                    showAddView = true
                }.sheet(isPresented: $showAddView) {
                    AddView(expenses: expenses)
                }
            }
            
            
        }
    }
}

#Preview {
    ContentView()
}
