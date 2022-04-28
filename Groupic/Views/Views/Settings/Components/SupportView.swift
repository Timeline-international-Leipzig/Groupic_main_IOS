//
//  SupportView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 21.04.22.
//

import SwiftUI

struct SupportView: View {
    @State var textFieldText: String = ""
    
    @Binding var back: Bool
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            ZStack {
                HStack(spacing: 15) {
                    Spacer()
                    
                    Text("Kontakt")
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
                        
            VStack(alignment: .center) {
                
                Text("Du hast Feedback oder es ist ein Problem")
                
                Text("aufgetreten? Lass es uns wissen!")
                
            }.padding()
            
            TextField(" ", text: $textFieldText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {},
                   label: {
                Label("Senden", systemImage: "arrow.up.circle")
                    .font(.system(size: 18))
                    .foregroundColor(Color(.black))
                    .font(.headline)
                    .padding(10)
                    .background(
                        Color("lightGray")
                            .cornerRadius(15)
                    )
            })
            
            Spacer()
            
        }
    }
}
