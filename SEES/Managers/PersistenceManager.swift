//
//  PersistenceManager.swift
//  SEES
//
//  Created by Robert Parsons on 11/24/20.
//

import Foundation

class PersistenceManager {
    public static let shared = PersistenceManager()
    private let defaults = UserDefaults.standard
    
    private init() { }
    
    func retrieve(completed: @escaping (Result<Student?, SEESError>) -> Void) {
        guard let studentData = self.defaults.object(forKey: Keys.student) as? Data else {
            completed(.success(nil))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedStudent = try decoder.decode(Student.self, from: studentData)
            completed(.success(decodedStudent))
        } catch {
            completed(.failure(.unableToRetrieveStudent))
        }
    }
    
    func save(student: Student) {
        do {
            let encoder = JSONEncoder()
            let encodedStudent = try encoder.encode(student)
            self.defaults.setValue(encodedStudent, forKey: Keys.student)
        } catch {
            print(SEESError.unableToSaveStudent)
        }
    }
    
    func remove(student: Student) {
        self.defaults.removeObject(forKey: Keys.student)
    }
}
