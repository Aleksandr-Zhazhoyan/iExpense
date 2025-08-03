//
//  ContentView.swift
//  iExpense
//
//  Created by Aleksandr Zhazhoyan on 16.07.2025.
//

import SwiftUI


@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}


struct ContentView: View {
    
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    @State private var title = "iExpense"
    
    var personalItems: [ExpenseItem] {
        expenses.items.filter { $0.type == .personal }
    }
    
    var businessItems: [ExpenseItem] {
        expenses.items.filter { $0.type == .business }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Business") {
                    ForEach(businessItems) { item in
                        ExpenseRow(item: item)
                        
                    }
                    .onDelete { offsets in
                        removeItems(at: offsets, in: businessItems)
                    }
                }
                
                Section("Personal") {
                    ForEach(personalItems) { item in
                        ExpenseRow(item: item)
                        
                    }
                    .onDelete { offsets in
                        removeItems(at: offsets, in: personalItems)
                    }
                }
                
                NavigationLink("Add Expense", destination: AddView(expenses: expenses), isActive: $showingAddExpense)
                    .hidden()
                
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .navigationBarBackButtonHidden()
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
        

    
    private func removeItems(at offsets: IndexSet, in items: [ExpenseItem]) {
           for offset in offsets {
               if let index = expenses.items.firstIndex(where: { $0.id == items[offset].id }) {
                   expenses.items.remove(at: index)
               }
           }
       }
}

#Preview {
    ContentView()
}
