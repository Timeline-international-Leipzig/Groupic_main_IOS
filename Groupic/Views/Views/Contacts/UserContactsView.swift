
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
                    Text("Noch keine Kontakte").font(.custom("Inter-Regular", size: 16))
                }
                
                VStack(spacing: 0) {
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
                                        if user.profileImageId == "" {
                                            Image("profileImage")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 50, height: 50, alignment: .center)
                                                .clipShape(Circle())
                                        }
                                        else {
                                            WebImage(url: URL(string: user.profileImageId))
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 50, height: 50, alignment: .center)
                                                .clipShape(Circle())
                                        }
                                        
                                        Text(user.username)
                                            .font(.custom("Inter-ExtraBold", size: 18))
                                            .foregroundColor(.white)
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
