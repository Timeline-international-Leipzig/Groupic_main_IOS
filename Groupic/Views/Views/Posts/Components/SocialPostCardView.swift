//
//  SocialPostCardView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 10.04.22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct SocialPostCardView: View {
    @StateObject var profileService = ProfileService()
    
    @State var postModel: PostModel
    @State var userModel: UserModel
    @State var next = false
    
    @Binding var exist: Bool
    
    @State var existsAcc = false
    
    var userCollection = Firestore.firestore().collection("users")
    
    var body: some View {
        if exist == true && postModel.index == 0 {
            NavigationLink(destination: EventView(postModel: $postModel, userModel: $userModel, next: $next), isActive: self.$next, label: {
                EmptyView()
            })
            
            VStack {
                HStack {
                    VStack {
                        HStack {
                            //Kreis
                            VStack {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 10))
                                
                                Color.gray.frame(width: CGFloat(2) / UIScreen.main.scale)
                            }
                            
                            if userModel.uid != Auth.auth().currentUser!.uid {
                                Text(userModel.userName + ": ")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(alignment: .topLeading)
                                    .offset(y: -5)
                            }
                            else {
                                Text("du: ")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(alignment: .topLeading)
                                    .offset(y: -5)
                            }
                            
                            Text((Date(timeIntervalSince1970: postModel.dateN))
                                .timeAgo())
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(alignment: .topLeading)
                            .offset(y: -5)
                        }
                        .padding(.horizontal)
                        
                        //Linie
                    }
                    
                    Spacer()
                }
                
                VStack {
                    Button(
                        action: {
                            self.next.toggle()
                        },
                        label: {
                            WebImage(url: URL(string: postModel.mediaUrl)!)
                                .resizable()
                                .frame(width: getRectView().width, height: 170, alignment: .center)
                                .clipped()
                        }
                    )
                    
                    HStack {
                        ForEach(profileService.eventElements.prefix(4), id: \.id){ item in
                            if item.type == "IMAGE" {
                                WebImage(url: URL(string: item.uriOrUid)!)
                                    .resizable()
                                    .frame(width: getRectView().width / 4, height: getRectView().width / 4, alignment: .center)
                                    .clipped()
                            }
                            else {
                            }
                        }
                    }
                    
                    HStack {
                        Color.gray.frame(width:CGFloat(2) / UIScreen.main.scale)
                            .offset(y: -8)
                        
                        ZStack {
                            HStack {
                                if Calendar.current.component(.day, from: postModel.startDate) == Calendar.current.component(.day, from: postModel.endDate) {
                                    Spacer()
                                    
                                    Text(postModel.startDate, style: .date)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(alignment: .topLeading)
                                }
                                
                                else {
                                    Spacer()
                                    
                                    Text(postModel.startDate, style: .date)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(alignment: .topLeading)
                                    
                                    Text(" - ")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(alignment: .topLeading)
                                    
                                    Text(postModel.endDate, style: .date)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(alignment: .topLeading)
                                }
                            }
                            
                            HStack {
                                Spacer()
                                
                                Text(postModel.caption)
                                    .font(.title3)
                                    .frame(width: 320, height: 40, alignment: .topLeading)
                                
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .offset(y: -10)
            }
            .onAppear {
                self.profileService.loadAllEventElements(postId: postModel.postId)
            }
        }
        
        if exist == false && postModel.index == 0 {
            NavigationLink(destination: EventViewOnlyContactView(postModel: postModel, userModel: $userModel, next: $next), isActive: self.$next, label: {
                EmptyView()
            })
            
            VStack {
                HStack {
                    VStack {
                        HStack {
                            //Kreis
                            VStack {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 10))
                                
                                Color.gray.frame(width: CGFloat(2) / UIScreen.main.scale)
                            }
                            
                            if userModel.uid != Auth.auth().currentUser!.uid {
                                Text(userModel.userName + ": ")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(alignment: .topLeading)
                                    .offset(y: -5)
                            }
                            else {
                                Text("du: ")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(alignment: .topLeading)
                                    .offset(y: -5)
                            }
                            
                            Text((Date(timeIntervalSince1970: postModel.dateN))
                                .timeAgo())
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(alignment: .topLeading)
                            .offset(y: -5)
                        }
                        .padding(.horizontal)
                        
                        //Linie
                    }
                    
                    Spacer()
                }
                
                VStack {
                    Button(
                        action: {
                            self.next.toggle()
                        },
                        label: {
                            
                            WebImage(url: URL(string: postModel.mediaUrl)!)
                                .resizable()
                                .frame(width: getRectView().width, height: 170, alignment: .center)
                                .clipped()
                        }
                    )
                    
                    HStack {
                        ForEach(profileService.eventElements.prefix(4), id: \.id){ item in
                            if item.type == "IMAGE" {
                                WebImage(url: URL(string: item.uriOrUid)!)
                                    .resizable()
                                    .frame(width: getRectView().width / 4, height: getRectView().width / 4, alignment: .center)
                                    .clipped()
                            }
                            else {
                            }
                        }
                    }
                    
                    HStack {
                        Color.gray.frame(width:CGFloat(2) / UIScreen.main.scale)
                            .offset(y: -8)
                        
                        ZStack {
                            HStack {
                                if Calendar.current.component(.day, from: postModel.startDate) == Calendar.current.component(.day, from: postModel.endDate) {
                                    Spacer()
                                    
                                    Text(postModel.startDate, style: .date)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(alignment: .topLeading)
                                }
                                
                                else {
                                    Spacer()
                                    
                                    Text(postModel.startDate, style: .date)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(alignment: .topLeading)
                                    
                                    Text(" - ")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(alignment: .topLeading)
                                    
                                    Text(postModel.endDate, style: .date)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(alignment: .topLeading)
                                }
                            }
                            
                            HStack {
                                Spacer()
                                
                                Text(postModel.caption)
                                    .font(.title3)
                                    .frame(width: 320, height: 40, alignment: .topLeading)
                                
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .offset(y: -10)
            }
            .onAppear {
                self.profileService.loadAllEventElements(postId: postModel.postId)
            }
        }
        
        if exist == true && postModel.index == 1 {
            NavigationLink(destination: EventView(postModel: $postModel, userModel: $userModel, next: $next), isActive: self.$next, label: {
                EmptyView()
            })
            
            VStack {
                HStack {
                    VStack {
                        HStack {
                            //Kreis
                            VStack {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 10))
                                
                                Color.gray.frame(width: CGFloat(2) / UIScreen.main.scale)
                            }
                            
                            if userModel.uid != Auth.auth().currentUser!.uid {
                                Text(userModel.userName + ": ")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(alignment: .topLeading)
                                    .offset(y: -5)
                            }
                            else {
                                Text("du: ")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(alignment: .topLeading)
                                    .offset(y: -5)
                            }
                            
                            Text((Date(timeIntervalSince1970: postModel.dateN))
                                .timeAgo())
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(alignment: .topLeading)
                            .offset(y: -5)
                        }
                        .padding(.horizontal)
                        
                        //Linie
                    }
                    
                    Spacer()
                }
                
                VStack {
                    Button(
                        action: {
                            self.next.toggle()
                        },
                        label: {
                            
                            WebImage(url: URL(string: postModel.mediaUrl)!)
                                .resizable()
                                .frame(width: getRectView().width, height: 170, alignment: .center)
                                .clipped()
                        }
                    )
                    
                    HStack {
                        ForEach(profileService.eventElements.prefix(4), id: \.id){ item in
                            if item.type == "IMAGE" {
                                WebImage(url: URL(string: item.uriOrUid)!)
                                    .resizable()
                                    .frame(width: getRectView().width / 4, height: getRectView().width / 4, alignment: .center)
                                    .clipped()
                            }
                            else {
                            }
                        }
                    }
                    
                    HStack {
                        Color.gray.frame(width:CGFloat(2) / UIScreen.main.scale)
                            .offset(y: -8)
                        
                        ZStack {
                            HStack {
                                if Calendar.current.component(.day, from: postModel.startDate) == Calendar.current.component(.day, from: postModel.endDate) {
                                    Spacer()
                                    
                                    Text(postModel.startDate, style: .date)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(alignment: .topLeading)
                                }
                                
                                else {
                                    Spacer()
                                    
                                    Text(postModel.startDate, style: .date)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(alignment: .topLeading)
                                    
                                    Text(" - ")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(alignment: .topLeading)
                                    
                                    Text(postModel.endDate, style: .date)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(alignment: .topLeading)
                                }
                            }
                            
                            HStack {
                                Spacer()
                                
                                Text(postModel.caption)
                                    .font(.title3)
                                    .frame(width: 320, height: 40, alignment: .topLeading)
                                
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .offset(y: -10)
            }
            .onAppear {
                self.profileService.loadAllEventElements(postId: postModel.postId)
            }
        }
        
        if postModel.index == 2 {
            VStack {
                ForEach(profileService.usersUid, id: \.uid) {
                    (userUid) in
                    
                    VStack {}
                        .onAppear {
                            checkIfUserExistsContacts(userId: Auth.auth().currentUser!.uid, participantId: userUid.uid) { result in
                                if (result == true) {
                                    self.existsAcc = true
                                    return
                                }
                                else {
                                    self.existsAcc = false
                                }
                            }
                        }
                }
            }
            .onAppear {
                self.profileService.loadAllEventUsers(postId: postModel.postId)
                self.profileService.loadAllUser(userId: Auth.auth().currentUser!.uid)
            }
            
            if postModel.index == 2 && existsAcc == true {
                NavigationLink(destination: EventViewOnlyContactView(postModel: postModel, userModel: $userModel, next: $next), isActive: self.$next, label: {
                    EmptyView()
                })
                
                VStack {
                    HStack {
                        VStack {
                            HStack {
                                //Kreis
                                VStack {
                                    Image(systemName: "circle")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 10))
                                    
                                    Color.gray.frame(width: CGFloat(2) / UIScreen.main.scale)
                                }
                                
                                if userModel.uid != Auth.auth().currentUser!.uid {
                                    Text(userModel.userName + ": ")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(alignment: .topLeading)
                                        .offset(y: -5)
                                }
                                else {
                                    Text("du: ")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(alignment: .topLeading)
                                        .offset(y: -5)
                                }
                                
                                Text((Date(timeIntervalSince1970: postModel.dateN))
                                    .timeAgo())
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .frame(alignment: .topLeading)
                                .offset(y: -5)
                            }
                            .padding(.horizontal)
                            
                            //Linie
                        }
                        
                        Spacer()
                        
                    }
                    
                    VStack {
                        Button(
                            action: {
                                self.next.toggle()
                            },
                            label: {
                                WebImage(url: URL(string: postModel.mediaUrl)!)
                                    .resizable()
                                    .frame(width: getRectView().width, height: 170, alignment: .center)
                                    .clipped()
                            }
                        )
                        
                        HStack {
                            ForEach(profileService.eventElements.prefix(4), id: \.id){ item in
                                if item.type == "IMAGE" {
                                    WebImage(url: URL(string: item.uriOrUid)!)
                                        .resizable()
                                        .frame(width: getRectView().width / 4, height: getRectView().width / 4, alignment: .center)
                                        .clipped()
                                }
                                else {
                                }
                            }
                        }
                        
                        HStack {
                            Color.gray.frame(width:CGFloat(2) / UIScreen.main.scale)
                                .offset(y: -8)
                            
                            ZStack {
                                HStack {
                                    if Calendar.current.component(.day, from: postModel.startDate) == Calendar.current.component(.day, from: postModel.endDate) {
                                        Spacer()
                                        
                                        Text(postModel.startDate, style: .date)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .frame(alignment: .topLeading)
                                    }
                                    
                                    else {
                                        Spacer()
                                        
                                        Text(postModel.startDate, style: .date)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .frame(alignment: .topLeading)
                                        
                                        Text(" - ")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .frame(alignment: .topLeading)
                                        
                                        Text(postModel.endDate, style: .date)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .frame(alignment: .topLeading)
                                    }
                                }
                                
                                HStack {
                                    Spacer()
                                    
                                    Text(postModel.caption)
                                        .font(.title3)
                                        .frame(width: 320, height: 40, alignment: .topLeading)
                                    
                                    Spacer()
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .offset(y: -10)
                }
                .onAppear {
                    self.profileService.loadAllEventElements(postId: postModel.postId)
                }
            }
            
            if exist == true && postModel.index == 2 {
                NavigationLink(destination: EventView(postModel: $postModel, userModel: $userModel, next: $next), isActive: self.$next, label: {
                    EmptyView()
                })
                
                VStack {
                    HStack {
                        VStack {
                            HStack {
                                //Kreis
                                VStack {
                                    Image(systemName: "circle")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 10))
                                    
                                    Color.gray.frame(width: CGFloat(2) / UIScreen.main.scale)
                                }
                                
                                if userModel.uid != Auth.auth().currentUser!.uid {
                                    Text(userModel.userName + ": ")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(alignment: .topLeading)
                                        .offset(y: -5)
                                }
                                else {
                                    Text("du: ")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(alignment: .topLeading)
                                        .offset(y: -5)
                                }
                                
                                Text((Date(timeIntervalSince1970: postModel.dateN))
                                    .timeAgo())
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .frame(alignment: .topLeading)
                                .offset(y: -5)
                            }
                            .padding(.horizontal)
                            
                            //Linie
                        }
                        
                        Spacer()
                    }
                    
                    VStack {
                        Button(
                            action: {
                                self.next.toggle()
                            },
                            label: {
                                
                                WebImage(url: URL(string: postModel.mediaUrl)!)
                                    .resizable()
                                    .frame(width: getRectView().width, height: 170, alignment: .center)
                                    .clipped()
                            }
                        )
                        HStack {
                            ForEach(profileService.eventElements.prefix(4), id: \.id){ item in
                                if item.type == "IMAGE" {
                                    WebImage(url: URL(string: item.uriOrUid)!)
                                        .resizable()
                                        .frame(width: getRectView().width / 4, height: getRectView().width / 4, alignment: .center)
                                        .clipped()
                                }
                                else {
                                }
                            }
                        }
                        
                        HStack {
                            Color.gray.frame(width:CGFloat(2) / UIScreen.main.scale)
                                .offset(y: -8)
                            
                            ZStack {
                                HStack {
                                    if Calendar.current.component(.day, from: postModel.startDate) == Calendar.current.component(.day, from: postModel.endDate) {
                                        Spacer()
                                        
                                        Text(postModel.startDate, style: .date)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .frame(alignment: .topLeading)
                                    }
                                    
                                    else {
                                        Spacer()
                                        
                                        Text(postModel.startDate, style: .date)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .frame(alignment: .topLeading)
                                        
                                        Text(" - ")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .frame(alignment: .topLeading)
                                        
                                        Text(postModel.endDate, style: .date)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .frame(alignment: .topLeading)
                                    }
                                }
                                
                                HStack {
                                    Spacer()
                                    
                                    Text(postModel.caption)
                                        .font(.title3)
                                        .frame(width: 320, height: 40, alignment: .topLeading)
                                    
                                    Spacer()
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .offset(y: -10)
                }
                .onAppear {
                    self.profileService.loadAllEventElements(postId: postModel.postId)
                }
            }
            else {}
        }
        else {}
    }
    
    func checkIfUserExistsContacts(userId: String, participantId: String, completion: @escaping ((Bool) -> () )) {
        self.userCollection.document(participantId).collection("contact").whereField("uid", isEqualTo: userId).getDocuments() {
            (QuerySnapshot, Error) in
            if let error = Error {
                print("Unable to query" + error.localizedDescription)
                completion(false)
            }
            else {
                if (QuerySnapshot!.count > 0) {
                    print("There is a user")
                    completion(true)
                }
                else {
                    print("There is no user")
                    completion(false)
                }
            }
        }
    }
    
    func check() {
        self.profileService.loadAllEventUsers(postId: postModel.postId)
        
        for userId in profileService.usersUid  {
            checkIfUserExistsContacts(userId: Auth.auth().currentUser!.uid, participantId: userId.uid) { result in
                if (result == true) {
                    self.existsAcc = true
                    return
                }
                else {
                    self.existsAcc = false
                }
            }
        }
    }
}



