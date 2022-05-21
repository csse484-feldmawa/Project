//
// Created by Will Feldman on 4/7/22.
//
import Foundation
import Firebase
import FirebaseAuth

class AuthManager : ObservableObject {
    private static var _shared: AuthManager?
    static var shared: AuthManager {
        let shared = _shared ?? AuthManager()
        _shared = shared
        return shared
    }
    
    private init() {
        startListening()
    }
    
    var currentUser: FirebaseAuth.User? { Auth.auth().currentUser }
    var isSignedIn: Bool { currentUser != nil }
    
    private var authStateChangeHandler: AuthStateDidChangeListenerHandle? = nil
    
    func startListening() {
        authStateChangeHandler = Auth.auth().addStateDidChangeListener { auth, user in
            self.objectWillChange.send()
        }
    }
    
    func stopListening() {
        if let handler = authStateChangeHandler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.objectWillChange.send()
        } catch let signOutError as NSError {
            print("Sign out failed: \(signOutError)")
        }
    }
}
