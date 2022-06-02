//
//  UserModel.swift
//  Groupic
//
//  Created by Anatolij Travkin on 05/10/2021.
//

import Foundation

struct UserModel: Encodable, Decodable {
    var uid: String
    var email: String
    var profileImageId: String
    var titleImageId: String
    var fullName: String
    var username: String
    var keyWords: [String]
    var availableStorage = 2097152
    var usedStorage = 0
    var events: [String] = []
    var comEvents: [String] = []
    var highLights: [String] = []
    var openActiveEvents = false
    var token = ""
}
