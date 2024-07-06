//
//  SignInEntity.swift
//  Sports
//
//  Created by ios Dev on 06/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - SignIn Request
struct SignInRequest: Encodable {
    let email: String
    let password: String
}

// MARK: - SignIn Entity
struct SignInEntity: Codable {
    let message: String?
    let data: SignInData?
}

// MARK: - DataClass
struct SignInData: Codable {
    let user: User?
    let token: String?
}
