//
//  TabButtonView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 13.12.21.
//

import SwiftUI

struct TabButtonView: View {
    @Binding var selectedTab: String
    
    var image: String
    
    var body: some View {
        Button(action: {selectedTab = image}) {
            Image(systemName: "\(image)")
                .foregroundColor(selectedTab == image ? Color("AccentColor"): Color.gray)
                .padding()
        }
    }
}
