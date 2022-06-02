//
//  PostModel.swift
//  Groupic
//
//  Created by Anatolij Travkin on 30.12.21.
//

import Foundation

struct PostModel: Encodable, Decodable, Equatable {    
    var highlighted: Bool
    var publishTime: Double
    var title: String
    var index: Int
    var creatorId: String
    var id: String
    var username: String
    var coverPic: String
    var startDate = Date()
    var endDate = Date()
    var adminIds: [String] = []
    var invited: [String] = []
    var participantIds: [String] = []
}
