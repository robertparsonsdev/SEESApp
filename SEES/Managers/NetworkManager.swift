//
//  NetworkManager.swift
//  SEES
//
//  Created by Robert Parsons on 11/15/20.
//

import Foundation
import Firebase

class NetworkManager {
    static let shared = NetworkManager()

    private init() { }
    
    func login(withEmail email: String, andPassword password: String, completed: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                completed(.failure(error))
                return
            }

            if let user = user {
                completed(.success(user))
            }
        }
    }
    
    func signOut(completed: @escaping (Result<Bool, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completed(.success(true))
        } catch let error {
            completed(.failure(error))
        }
    }
    
    func fetchStudent(completed: @escaping (Result<Student, SEESError>) -> Void) {
        guard let email = Auth.auth().currentUser?.email?.components(separatedBy: "@")[0] else {
            completed(.failure(.unableToGetCurrentStudent))
            return
        }
        
        Database.database().reference().child("users").child(email).observeSingleEvent(of: .value) { (snapshot) in
            guard let studentDictionary = snapshot.value as? [String: Any] else { completed(.failure(.unableToRetrieveData)); return }
            print("here")
            let student = Student(dictionary: studentDictionary)
            completed(.success(student))
        }
    }
}
