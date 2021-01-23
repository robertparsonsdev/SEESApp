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
    
    func fetchData<T: SEESDataModel>(for type: FBDataType, completed: @escaping (Result<[T], SEESError>) -> Void) {
        guard let path = buildPath(for: type) else { completed(.failure(.unableToGetCurrentStudent)); return }
        
        Database.database().reference().child(path).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { completed(.failure(.unableToRetrieveData)); return }
            
            switch type {
            case .students:
                if let studentDictionary = dictionary as? [String: String] {
                    completed(.success([T(dictionary: studentDictionary)]))
                } else {
                    completed(.failure(.unableToRetrieveData))
                }
            default:
                var models: [T] = []
                for (_, value) in dictionary {
                    if let dataDictionary = value as? [String: String] {
                        models.append(T(dictionary: dataDictionary))
                    } else {
                        completed(.failure(.unableToRetrieveData))
                        return
                    }
                }
                completed(.success(models))
            }
        }
    }
    
    private func buildPath(for type: FBDataType) -> String? {
        switch type {
        case .students:
            if let email = Auth.auth().currentUser?.email?.components(separatedBy: "@").getItemAt(0) {
                return "/\(type.key)/\(email)"
            } else {
                return nil
            }
        default:
            return "/\(type.key)"
        }
    }
}
