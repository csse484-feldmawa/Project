//
//  Lift.swift
//  WorkoutTracker
//
//  Created by Will Feldman on 5/18/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Lift: Identifiable, Codable {
    var name: String
    @DocumentID var documentId: String?
    var id: String {documentId!}
}
