//
//  LoginBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 28/10/21.
//

import Foundation

class LoginBussines {
    // hacer constructor
    private let webService = WebService()
    
    func postLogin(
        email: String,
        password: String,
        onFinishedBussines: @escaping (Bool) ->Void)
    {
        let loginReq = User(email: email, password: password)
        webService.postLogin(
            user: loginReq,
            onFinished: { isSucces in
                onFinishedBussines(isSucces)
        })
    }
}
