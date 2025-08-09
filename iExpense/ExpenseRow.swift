//
//  ExpenseRow.swift
//  iExpense
//
//  Created by Aleksandr Zhazhoyan on 19.07.2025.
//

import SwiftData
import SwiftUI

struct ExpenseRow: View {
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type.rawValue)
                    .font(.subheadline)
            }
            
            Spacer()
            
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundStyle(amountColor(for: item.amount))
        }
    }
    
    private func amountColor(for amount: Double) -> Color {
        switch amount {
        case 0..<10: .red
        case 10..<100: .orange
        default: .indigo
        }
    }
}
