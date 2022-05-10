//
//  DataModel.swift
//  Groupic
//
//  Created by Anatolij Travkin on 02.05.22.
//

import SwiftUI

struct DataPost: Codable, Identifiable {
    let id: UUID()
    var title: String
    var body: String
}
