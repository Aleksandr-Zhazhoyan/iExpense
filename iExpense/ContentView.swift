//
//  ContentView.swift
//  iExpense
//
//  Created by Aleksandr Zhazhoyan on 16.07.2025.
//

import SwiftData
import SwiftUI


struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\ExpenseItem.name, order: .forward)])
    private var expenses: [ExpenseItem]
    
    @State private var showingAddExpense = false
    @State private var sortOption: SortOption = .name
    @State private var filterOption: FilterOption = .all
    
    enum SortOption: String, CaseIterable {
        case name = "Name"
        case amount = "Amount"
    }
    
    enum FilterOption: String, CaseIterable {
        case all = "All"
        case personal = "Personal"
        case business = "Business"
    }
    
    var filteredExpenses: [ExpenseItem] {
        expenses.filter { item in
            switch filterOption {
            case .all: true
            case .personal: item.type == .personal
            case .business: item.type == .business
            }
        }
        .sorted {
            switch sortOption {
            case .name: $0.name.localizedCompare($1.name) == .orderedAscending
            case .amount: $0.amount < $1.amount
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredExpenses) { item in
                    ExpenseRow(item: item)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Menu("Sort") {
                        Picker("Sort by", selection: $sortOption) {
                            ForEach(SortOption.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                    }
                    
                    Menu("Filter") {
                        Picker("Filter by", selection: $filterOption) {
                            ForEach(FilterOption.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("", systemImage: "plus") {
                        showingAddExpense = true
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView()
            }
        }
    }
        

    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(filteredExpenses[index])
        }
    }
}

#Preview {
    ContentView()
}
