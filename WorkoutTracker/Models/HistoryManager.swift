//
//  HistoryManager.swift
//  WorkoutTracker
//
//  Created by Will Feldman on 5/18/22.
//

import Foundation
import Firebase

class HistoryManager: ObservableObject {
    var collectionReference: CollectionReference
    var listener: ListenerRegistration?
    @Published var history: [History]
    
    init(liftId: String) {
        collectionReference = Firestore.firestore().collection(LiftConstants.collectionPath).document(liftId).collection(HistoryConstants.collectionPath)
        history = []
    }
    
    func startListening() {
        collectionReference
            .whereField(HistoryConstants.userKey, isEqualTo: AuthManager.shared.currentUser?.uid ?? "")
            .order(by: HistoryConstants.dateKey, descending: true)
            .addSnapshotListener {snapshot, error in
            if let snapshot = snapshot {
                let documents = snapshot.documents
                self.history = documents.compactMap { document in
                    do {
                        return try document.data(as: History.self)
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
    
    func addHistory(weight: Int, reps: Int, notes: String) {
        let uid = AuthManager.shared.currentUser?.uid
        let historyElement = History(weight: weight, reps: reps, date: Date(), notes: notes, uid: uid ?? "")
        do {
            let _ = try collectionReference.addDocument(from: historyElement)
        } catch {
            print("Failed to add history")
        }
    }
    
    func removeHistory(documentId: String) {
        collectionReference.document(documentId).delete()
    }
}
