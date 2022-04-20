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
            
            VStack(alignment: .center, spacing: 0) {
                
                ZStack {
                    HStack(spacing: 15) {
                        Spacer()
                        
                        Text("Datenschutzerklärung")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(alignment: .center)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color("darkBlue"))
                    
                    HStack {
                        Button(action: {
                            self.back.toggle()
                        },
                        label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                        
                            Spacer()
                        })
                    }
                    .padding()
                }.zIndex(1)
                
                WebView(url: URL(string: "https://www.iubenda.com/privacy-policy/19125315"))
            }
        }
}
