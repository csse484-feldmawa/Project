//
//  History.swift
//  WorkoutTracker
//
//  Created by Will Feldman on 5/18/22.
//

import Foundation
import FirebaseFirestoreSwift

struct History: Identifiable, Codable {
    var weight: Int
    var reps: Int
    var date: Date
    var notes: String
    var uid: String
    @DocumentID var documentId: String?
    var id: String {documentId!}
}
