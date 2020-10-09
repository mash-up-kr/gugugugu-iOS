//
//  KeyChain.swift
//  gugugugu
//
//  Created by JU HO YOON on 2020/10/09.
//  Copyright © 2020 JU HO YOON. All rights reserved.
//

import Foundation
import KeychainAccess

private extension String {
    static var `mainService`: String {
        "com.gugugugu.gugugugu.userID"
    }
}

final class UserManager {

    static let shared = UserManager()
    let keychain = Keychain(service: .mainService)
    var userID: Int?

    init() {
        if let userIDString = keychain[.mainService],
           let userID = Int(userIDString) {
            self.userID = userID
        }
    }

    func update(_ user: User) {
        keychain[.mainService] = String(user.userID)
    }

    func delete(_ user: User) {
        keychain[.mainService] = nil
    }
}
