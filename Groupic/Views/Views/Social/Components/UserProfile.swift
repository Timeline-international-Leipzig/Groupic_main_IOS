//
//  UserProfile.swift
//  Groupic
//
//  Created by Anatolij Travkin on 14.03.22.
//

import SwiftUI

struct UserProfie: View {
    @State private var value: String = ""
    @State var users: [UserModel] = []
    @State var isLoading = false
    
    func searchUsers() {
        isLoading = true
        
        SearchService.searchUser(input: value) {
            (users) in
            self.isLoading = false
            self.users = users
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                
            }
        }
    }
}
