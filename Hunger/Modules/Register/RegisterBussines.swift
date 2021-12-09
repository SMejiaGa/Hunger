//
//  RegisterBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 28/10/21.
//

import Foundation

final class RegisterBussines {
    let registerService: RegisterService
    
    init(service: RegisterService) {
        self.registerService = service
    }
    
    func postRegister(
        email: String,
        password: String,
        onFinished: @escaping (Bool) -> Void) {
        let loginReq = User(email: email, password: password)
            registerService.postRegister(
                user: loginReq,
                onFinished: { isSucces in
                onFinished(isSucces)
        })
    }
}
