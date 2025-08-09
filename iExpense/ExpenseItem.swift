//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Aleksandr Zhazhoyan on 19.07.2025.
//

import Foundation
import SwiftData

enum ExpenseType: String, CaseIterable, Codable {
    case business = "Business"
    case personal = "Personal"
}

@Model
class ExpenseItem {
    var id = UUID()
    var name: String
    var type: ExpenseType
    var amount: Double
    
    init(id: UUID = UUID(), name: String, type: ExpenseType, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}
