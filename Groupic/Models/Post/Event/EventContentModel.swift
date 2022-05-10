//
//  EventContentModel.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04.05.22.
//


import Foundation

struct EventContentModel: Encodable, Decodable {
    var id: String
    var stamp = Date()
    var text: String
    var type: String
    var uriOrUid: String
    var userUid: String
}
