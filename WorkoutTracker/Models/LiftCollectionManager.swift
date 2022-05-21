//
//  LiftCollectionManager.swift
//  WorkoutTracker
//
//  Created by Will Feldman on 5/18/22.
//

import Foundation
import Firebase

class LiftCollectionManager: ObservableObject {
    var collectionReference: CollectionReference
    var listener: ListenerRegistration?
    @Published var lifts: [Lift]
    
    init() {
        collectionReference = Firestore.firestore().collection(LiftConstants.collectionPath)
        lifts = []
    }
    
    func startListening() {
        collectionReference.addSnapshotListener {snapshot, error in
            if let snapshot = snapshot {
                let documents = snapshot.documents
                self.lifts = documents.compactMap { document in
                    do {
                        return try document.data(as: Lift.self)
                    } catch {
                        print("Failed to map lift")
                        return nil
                    }
                }
            }
        }
    }
    
    func stopListening() {
        listener?.remove()
    }
}
