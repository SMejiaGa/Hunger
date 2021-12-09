//
//  LoginBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 28/10/21.
//

import Foundation

final class LoginBussines {

    private let service: LoginService
    
    init(service: LoginService) {
        self.service = service
        
    }
    
    func postLogin(
        email: String,
        password: String,
        onFinishedBussines: @escaping (Bool) -> Void
    ) {
        let loginReq = User(email: email, password: password)
        service.postLogin(
            user: loginReq,
            onFinished: { isSucces in
                onFinishedBussines(isSucces)
        })
    }
}
