//
//  HistoryItem.swift
//  WorkoutTracker
//
//  Created by Will Feldman on 5/18/22.
//

import SwiftUI

struct HistoryItem: View {
    var historyItem: History
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: historyItem.date)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(historyItem.weight)x\(historyItem.reps)")
                    .padding([.leading], 5)
                Spacer()
                Text(date)
                    .padding([.trailing], 5)
            }
            Text(historyItem.notes)
        }
    }
}
