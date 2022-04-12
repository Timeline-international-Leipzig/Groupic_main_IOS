//
//  RegistrationProtocol.swift
//  Groupic
//
//  Created by Anatolij Travkin on 06.04.22.
//

import Combine
import Foundation
import Firebase

protocol RegistrationProtocol {
    func register(with credentials: UserModel) -> AnyPublisher<Void, Error>
}
