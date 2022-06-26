//
//  ErrorView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 03/10/2021.
//

import SwiftUI

struct ErrorView: View {
    @State var color = Color.black.opacity(0.7)
    @State var time = 1
    
    @Binding var alert: Bool
    @Binding var error: String
    @State var closetitle = "Schließen"
        
    var body: some View {
        
        VStack {
            
            Spacer()
        
            HStack {
                Spacer()
                
                VStack {
                    Text(self.error)
                        .font(.custom("Inter-Regular", size: 16))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                        .padding(.horizontal, 25)
                    
                    Button(action: {
                        self.alert.toggle()
                        
                    }, label: {
                        Text(self.closetitle)
                            .font(.custom("Inter-ExtraBold", size: 20))
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 120)
                    })
                    .background(Color("AccentColor"))
                    .cornerRadius(10)
                    .padding(.top, 25)
                }
                .padding(.all, 25)
                .frame(width: UIScreen.main.bounds.width - 90)
                .background(Color.black.opacity(0.95))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
                .frame(height: UIScreen.main.bounds.height - 50)
                
                Spacer()
            }
        }.background(Color.black.opacity(0.10).edgesIgnoringSafeArea(.all))
    }

    func performAfter(delay: TimeInterval, completion: @escaping () -> Void) {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                completion()
            }
    }
}


    


