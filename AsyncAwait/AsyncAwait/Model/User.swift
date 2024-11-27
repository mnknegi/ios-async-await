//
//  User.swift
//  AsyncAwait
//
//  Created by Mayank Negi on 26/10/24.
//

import Foundation

struct UserData: Decodable {
    let data: [User]
}

struct User: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let avatar: String

    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email, avatar, id
    }
}
