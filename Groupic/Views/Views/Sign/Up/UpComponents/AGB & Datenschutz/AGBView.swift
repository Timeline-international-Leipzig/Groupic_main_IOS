//
//  AGBView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 20.04.22.
//

import SwiftUI

struct AGBView: View {
    @Binding var back: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
                        
            WebView(url: URL(string: "https://groupic.de/agb"))
        }
    }
}
