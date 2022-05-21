//
//  LiftView.swift
//  WorkoutTracker
//
//  Created by Will Feldman on 5/18/22.
//

import SwiftUI

struct LiftView: View {
    @State var weight: Int = 0
    @State var reps: Int = 0
    @State var notes: String = ""
    @StateObject var historyManager: HistoryManager
    @State var displayingError = false
    var liftName: String
    
    init(liftId: String, liftName: String) {
        _historyManager = StateObject(wrappedValue: HistoryManager(liftId: liftId))
        self.liftName = liftName
    }
    
    var body: some View {
        TabView {
            VStack {
                HStack {
                    Text("Weight: ")
                    TextField("", value: $weight, formatter: NumberFormatter())
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                }
                .padding([.leading, .trailing], 5)
                HStack {
                    Text("Reps: ")
                    TextField("", value: $reps, formatter: NumberFormatter())
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                }
                .padding([.leading, .trailing], 5)
                HStack {
                    Text("Notes: ")
                    TextField("", text: $notes)
                        .textFieldStyle(.roundedBorder)
                }
                .padding([.leading, .trailing], 5)
                Button("Add") {
//                    guard let weight = weight else {
//                        displayingError = true
//                        return
//                    }
//                    guard let reps = reps else {
//                        displayingError = true
//                        return
//                    }
                    historyManager.addHistory(weight: weight, reps: reps, notes: notes)
                    self.weight = 0
                    self.reps = 0
                    notes = ""
                }
                Spacer()
            }
                .tabItem {
                    Text("Add Set")
                }
            List {
                ForEach(historyManager.history) {historyItem in
                    HistoryItem(historyItem: historyItem)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        historyManager.removeHistory(documentId: historyManager.history[index].id)
                    }
                }
            }
                .tabItem {
                    Text("View History")
                }
        }
        .onAppear {
            historyManager.startListening()
        }
        .onDisappear {
            historyManager.stopListening()
        }
        .navigationTitle(liftName)
//        .alert("Invalid Set", isPresented: $displayingError) {
//            Button("Ok") {}
//        }
    }
}
