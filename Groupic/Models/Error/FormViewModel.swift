//
//  SwiftUIView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 24.11.21.
//

import SwiftUI
import Combine

class FormViewModel: ObservableObject {
    @Published var name = ""
    @Published var username = ""
    @Published var password = ""
    @Published var repassword = ""
    
    @Published var inlineErrorForPassword = ""
    
    @Published var valid = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private static let predicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{8,}$")
    
    private var isUserNameValidPublisher: AnyPublisher < Bool, Never > {
        $username
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.count >= 6 }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordEmptyPublisher: AnyPublisher < Bool, Never > {
        $password
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.count >= 6 }
            .eraseToAnyPublisher()
    }
    
    private var arePasswordsEqualPublisher: AnyPublisher < Bool, Never > {
        Publishers.CombineLatest($password, $repassword)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map { $0 == $1 }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordStrongPublisher: AnyPublisher < Bool, Never > {
        $password
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
                Self.predicate.evaluate(with: $0)
            }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordValidPublisher: AnyPublisher < PasswordStatus, Never > {
        Publishers.CombineLatest3(isPasswordEmptyPublisher, isPasswordStrongPublisher, arePasswordsEqualPublisher)
            .map {
                if $0 { return PasswordStatus.empty }
                if !$1 { return PasswordStatus.notStrongEnough }
                if !$2 { return PasswordStatus.repeatedPasswordWrong }
                
                return PasswordStatus.valid
            }
            .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: AnyPublisher < Bool, Never > {
        Publishers.CombineLatest(isPasswordValidPublisher, isUserNameValidPublisher)
            .map { $0 == .valid && $1 }
            .eraseToAnyPublisher()
    }
    
    init() {
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.valid, on: self)
            .store(in: &cancellables)
        
        isPasswordValidPublisher
            .dropFirst()
            .receive(on: RunLoop.main)
            .map { PasswordStatus in
                switch PasswordStatus {
                case .empty:
                    return "Es wurde kein Passwort eingetragen"
                case .notStrongEnough:
                    return "Password aus mindesten 8 Zeichen bestehen und es dürfen keine Sonderzeichen verwendet werden"
                case .repeatedPasswordWrong:
                    return "Passwörter stimmen nicht überein"
                case .valid:
                    return ""
                }
            }
            .assign(to: \.inlineErrorForPassword, on: self)
            .store(in: &cancellables)
    }
}
