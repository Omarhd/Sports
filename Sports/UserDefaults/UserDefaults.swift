//
//  UserDefaults.swift
//  Sports
//
//  Created by ios Dev on 06/07/2024.
//

import Foundation

extension UserDefaults {
    
    // MARK: - Save and Retrieve User
    func saveUser(_ user: User, forKey key: String) throws {
        let encodedData = try JSONEncoder().encode(user)
        set(encodedData, forKey: key)
    }
    
    func retrieveUser(forKey key: String) throws -> User? {
        guard let encodedData = data(forKey: key) else { return nil }
        return try JSONDecoder().decode(User.self, from: encodedData)
    }
    
    func hasSavedUser(forKey key: String) -> Bool {
        return data(forKey: key) != nil
    }
    
    func removeUser(forKey key: String) {
        removeObject(forKey: key)
    }
    
    // MARK: - Retrieve Token
    func retrieveToken(forKey key: String) -> String? {
        return string(forKey: key)
    }
}

