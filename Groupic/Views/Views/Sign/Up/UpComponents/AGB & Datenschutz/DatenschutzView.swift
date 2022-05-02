//
//  DatenschutzView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 20.04.22.
//

import SwiftUI

struct DatenschutzView: View {
    @Binding var back: Bool
    
    var body: some View {
            VStack {
                
                WebView(url: URL(string: "https://www.iubenda.com/privacy-policy/19125315"))
            }
        }
}
