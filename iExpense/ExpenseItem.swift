//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Aleksandr Zhazhoyan on 19.07.2025.
//

import Foundation


enum ExpenseType: String, CaseIterable, Codable {
    case business = "Business"
    case personal = "Personal"
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    let type: ExpenseType
    let amount: Double
}
