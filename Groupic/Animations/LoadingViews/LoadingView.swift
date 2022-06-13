//
//  LoadingView.swift
//  Groupic
//
//  Created by Johannes Busch on 13.06.22.
//

import SwiftUI

struct LoadingScreen: View {
    
    @State private var isLoading = false
    
    var body: some View {
        
        ZStack {
            
            Color("mainColor").ignoresSafeArea()
            
            Text("Geladener Text")
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.white)
            
            if isLoading {
                
                LoadingView()
            }
        }
        .onAppear { startFakeNetworkCall() }
    }
    
    func startFakeNetworkCall() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            isLoading = false
        }
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.black).ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color("themeColor2")))
                .scaleEffect(1.5)
        }
    }
}
