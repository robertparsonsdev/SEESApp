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
}
