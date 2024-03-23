//
//  DeleteItemView.swift
//  SwiftUI-iExpense
//
//  Created by JimmyChao on 2024/3/23.
//

import SwiftUI

struct DeleteItemView: View {
    
    @State private var numbers = [Int]()
    @State private var currentNum = 1
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(numbers, id: \.self) {
                    Text("number\($0)")
                }.onDelete {
                    removeRow(at: $0)
                }
                
                Button("Add row") {
                    
                    withAnimation {
                        numbers.append(currentNum)
                    }
                    currentNum += 1
                }
            }
            .navigationTitle("Delete Items")
            .toolbar { EditButton() }
            
        }
    }
    
    private func removeRow(at indexSet: IndexSet) {
        numbers.remove(atOffsets: indexSet)
    }
}

#Preview {
    DeleteItemView()
}
