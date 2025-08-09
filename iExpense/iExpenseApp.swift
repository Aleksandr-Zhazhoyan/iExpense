//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Aleksandr Zhazhoyan on 16.07.2025.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
