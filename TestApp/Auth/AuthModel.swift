//
//  AuthModel.swift
//  TestApp
//
//  Created by Sergey Koriukin on 14/05/2020.
//  Copyright © 2020 Sergey Koriukin. All rights reserved.
//

import Foundation


enum AuthError: LocalizedError {
    case error(_ description: String)
    
    var errorDescription: String? {
        if case .error(let description) = self {
            return description
        }
        return nil
    }
}

class AuthModel {
    
    let mylogin = "myLogin"
    let myPassword = "myPassword"
    
    
    
    func signIn(withLogin login: String, password: String) -> Result<String, AuthError> {
        if mylogin == login && myPassword == password {
            return .success(mylogin)
        }
        return .failure(AuthError.error("Неправильный логин или пароль"))
    }
}
