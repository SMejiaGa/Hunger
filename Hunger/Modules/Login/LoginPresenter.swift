//
//  LoginPresenter.swift
//  Hunger
//
//  Created by Sebastian Mejia on 28/10/21.
//

import Foundation

protocol LoginPresenterDelegate: AnyObject {
    func startLogin(email: String, password: String)
    func showLoginResult(result: Bool)
}

final class LoginPresenter {

    private let service: LoginService
    private weak var loginaViewDelegate: LoginPresenterDelegate?
    
    init(service: LoginService) {
        self.service = service
        
    }
    
    func postLogin(
        email: String,
        password: String
    ) {
        let loginReq = User(email: email, password: password)
        service.postLogin(
            user: loginReq,
            onFinished: { [weak self] isSucces in
                self?.loginaViewDelegate?.showLoginResult(result: isSucces)
        })
    }
    
    func setViewDelegate(delegate: LoginPresenterDelegate) {
        self.loginaViewDelegate = delegate
    }
}
