//
//  AddView.swift
//  iExpense
//
//  Created by Aleksandr Zhazhoyan on 19.07.2025.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type: ExpenseType = .personal
    @State private var amount = 0.0
    
    var expenses: Expenses
    
    let types = ExpenseType.allCases
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(ExpenseType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
