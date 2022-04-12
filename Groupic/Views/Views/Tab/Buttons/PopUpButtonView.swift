//
//  PopUpButtonView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 27.12.21.
//

import SwiftUI

struct PopUpButtonView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 18) {
            Button(action: {
                
            }) {
                HStack(spacing: 15) {
                    Image(systemName: "camera")
                        .renderingMode(.original)
                    Text("Kamera")
                }
            }
            
            Divider()
            
            Button(action: {
                
            }) {
                HStack(spacing: 15) {
                    Image(systemName: "photo.artframe")
                        .renderingMode(.original)
                    Text("Galerie")
                }
            }
        }
        .frame(width: 140)
        .padding()
        .padding(.bottom, 20)
        .background(Color.black.opacity(0.05))
        .clipShape(ArrowShape())
        .cornerRadius(10)
        .offset(y: -5)
    }
}

struct ArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        let center = rect.width/2
        return Path {path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height - 20))
            
            path.addLine(to: CGPoint(x: center - 15, y: rect.height - 20))
            path.addLine(to: CGPoint(x: center, y: rect.height - 5))
            path.addLine(to: CGPoint(x: center + 15, y: rect.height - 20))
            
            path.addLine(to: CGPoint(x: 0, y: rect.height - 20))
        }
    }
}
