//
//  LiftsView.swift
//  WorkoutTracker
//
//  Created by Will Feldman on 5/18/22.
//

import SwiftUI

struct LiftsView: View {
    @StateObject var liftsManager = LiftCollectionManager()
    @State var searchText: String = ""
    var body: some View {
        VStack {
            TextField("search", text: $searchText)
                .textFieldStyle(.roundedBorder)
        .padding()
            List {
                ForEach(liftsManager.lifts.filter({$0.name.lowercased().starts(with: searchText.lowercased())})) { lift in
                    NavigationLink(lift.name, destination: LiftView(liftId: lift.id, liftName: lift.name))
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Log Out") {
                    AuthManager.shared.signOut()
                }
            }
        }
        .navigationTitle("Lifts")
        .onAppear {
            liftsManager.startListening()
        }
        .onDisappear {
            liftsManager.stopListening()
        }
    }
}
