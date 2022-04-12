//
//  ModalView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 31.03.22.
//

import SwiftUI

struct ModalView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                mainView
                    .transition(.move(edge: .bottom))
            }
        }
    }
    
    var mainView: some View {
        VStack {
            ZStack {
                VStack {
                    
                }
            }
        }
    }
}
