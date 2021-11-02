//
//  RegisterBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 28/10/21.
//

import Foundation

class RegisterBussines {
    let webService = WebService()
    
    func postRegister(
        email: String,
        password: String,
        onFinished: @escaping (Bool) ->Void) {
        let loginReq = User(email: email, password: password)
            webService.postRegister(
                user: loginReq,
                onFinished: { isSucces in
            if isSucces {
                onFinished(isSucces)
            } else {
                onFinished(false)
            }
        })
    }
}
