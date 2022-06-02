
import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct UserContactsView: View {
    @StateObject var profileService = ProfileService()
    @ObservedObject var followService = FollowService()
    
    @State var user: UserModel
    
    @State var userSelected: UserModel?
    @State var users: [UserModel] = []
    
    @State var next = false
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    Text("Noch keine Kontakte")
                }
                
                VStack {
                    ForEach(profileService.users, id: \.uid) {
                        (user) in
                        
                        ForEach(profileService.followUsers, id: \.uid) {
                            (users) in
                            
                            if user.uid == users.uid {
                                Button(action: {
                                    self.userSelected = user
                                    
                                    next.toggle()
                                }, label: {
                                    HStack {
                                        if user.profileImageUrl == "" {
                                            Image("profileImage")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 50, height: 50, alignment: .center)
                                                .clipShape(Circle())
                                        }
                                        else {
                                            WebImage(url: URL(string: user.profileImageUrl))
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 50, height: 50, alignment: .center)
                                                .clipShape(Circle())
                                        }
                                        
                                        Text(user.userName)
                                            .foregroundColor(.white)
                                            .font(.system(size: 18, weight: .bold))
                                            .padding(.horizontal)
                                        
                                        Spacer()
                                    }
                                    .padding()
                                })
                            }
                        }
                    }
                    
                    NavigationLink(destination: UserProfileView(user: $userSelected, next: $next), isActive: self.$next, label: {
                        EmptyView()
                    })
                }
                .background(Color("mainColor"))
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            self.profileService.loadAllUser(userId: user.uid)
            self.profileService.loadUser(userId: user.uid)
        }
    }
}
