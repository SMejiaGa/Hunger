//
//  LoginBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 28/10/21.
//

import Foundation

final class LoginBussines {

    private let loginService: LoginService
    
    init(service: LoginService) {
        self.loginService = service
        
    }
    
    func postLogin(
        email: String,
        password: String,
        onFinishedBussines: @escaping (Bool) -> Void
    ) {
        let loginReq = User(email: email, password: password)
        loginService.postLogin(
            user: loginReq,
            onFinished: { isSucces in
                onFinishedBussines(isSucces)
        })
    }
}
