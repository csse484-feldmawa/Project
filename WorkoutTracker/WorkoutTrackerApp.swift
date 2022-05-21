//
//  WorkoutTrackerApp.swift
//  WorkoutTracker
//
//  Created by Will Feldman on 5/16/22.
//

import SwiftUI
import Firebase

@main
struct WorkoutTrackerApp: App {
    @ObservedObject var authManager: AuthManager
    
    init() {
        FirebaseApp.configure()
        _authManager = ObservedObject(wrappedValue: AuthManager.shared)
        authManager.startListening()
    }
    
    var body: some Scene {
        WindowGroup {
            if authManager.isSignedIn {
                NavigationView {
                    LiftsView()
                }
                .navigationViewStyle(.stack)
            } else {
                CustomLoginViewController() {error in
                    print(error)
                }
            }
        }
    }
}
