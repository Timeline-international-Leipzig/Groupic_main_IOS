//
//  TabButton.swift
//  Groupic
//
//  Created by Anatolij Travkin on 27.12.21.
//

import SwiftUI

struct TabButton: View {
    @Binding var selectedTab: String
    
    var image: String
    
    var body: some View {
        Button(action: {selectedTab = image}) {
            Image(image)
                .renderingMode(.template)
                .foregroundColor(selectedTab == image ? Color("AccentColor") : Color.black.opacity(0.4))
                .padding()
        }
    }
}

