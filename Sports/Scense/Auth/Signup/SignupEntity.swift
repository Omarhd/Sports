//
//  SignupEntity.swift
//  Sports
//
//  Created by ios Dev on 04/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - SignupEntity
struct SignupEntity: Codable {
    let message: String?
    let data: SignUPData?
}

// MARK: - DataClass
struct SignUPData: Codable {
    let user: SignedUser?
    let token: String?
}

// MARK: - SignedUser
struct SignedUser: Codable {
    let id: Int?
    let name, email, createdAt, updatedAt: String?
    let profileImage, emailVerifiedAt: String?
    let isFollowing: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case profileImage = "profile_image"
        case emailVerifiedAt = "email_verified_at"
        case isFollowing = "is_following"
    }
}

// MARK: - Signup Request
struct signupRequest: Encodable {
    let name: String
    let email: String
    let password: String
    let confirmPassword: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case email
        case password
        case confirmPassword = "password_confirmation"
    }
}
