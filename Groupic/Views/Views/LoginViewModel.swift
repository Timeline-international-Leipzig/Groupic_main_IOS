//
//  LoginViewModel.swift
//  Groupic
//
//  Created by Anatolij Travkin on 27/09/2021.
//

import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {
    @Published var code = ""
    @Published var number = ""
    
    /// Errors
    @Published var errorMsg = ""
    @Published var error = false
    
    func verifyUser() {
    }
}

