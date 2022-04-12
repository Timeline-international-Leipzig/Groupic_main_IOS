//
//  EventModel.swift
//  Groupic
//
//  Created by Anatolij Travkin on 25.03.22.
//

import Foundation

struct EventPostModel: Encodable, Decodable {
    var highlighted: Bool
    var dateN: Double
    var caption: String
    var index: Int
    var likes: [String: Bool]
    var geoLocation: String
    var ownerId: String
    var postId: String
    var username: String
    var profile: String
    var mediaUrl: String
    var startDate = Date()
    var endDate = Date()
    var likeCount: Int
}
