//
//  PostModel.swift
//  Groupic
//
//  Created by Anatolij Travkin on 30.12.21.
//

import Foundation

struct PostModel: Encodable, Decodable, Equatable {    
    var highlighted: Bool
    var dateN: Double
    var caption: String
    var index: Int
    var likes: [String: Bool]
    var geoLocation: String
    var ownerId: String
    var postId: String
    var username: String
    var mediaUrl: String
    var startDate = Date()
    var endDate = Date()
    var likeCount: Int
}
