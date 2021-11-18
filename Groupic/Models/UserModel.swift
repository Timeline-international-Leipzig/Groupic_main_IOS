//
//  UserModel.swift
//  Groupic
//
//  Created by Anatolij Travkin on 05/10/2021.
//

import Foundation

struct User: Encodable, Decodable {
    var uid: String
    var email: String
    var profileImageUrl: String
    var userName: String
    var searchName: [String]
    var bio: String
}
