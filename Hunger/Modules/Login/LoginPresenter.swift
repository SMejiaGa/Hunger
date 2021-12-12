//
//  LoginPresenter.swift
//  Hunger
//
//  Created by Sebastian Mejia on 28/10/21.
//

import Foundation

protocol LoginPresenterDelegate: AnyObject {
    func showLoginResult(result: Bool)
    func getEmail() -> String
    func getPassword() -> String
    func showError(message: String)
    func toggleLoader(isEnabled: Bool)
    
}

final class LoginPresenter {
    
    private let service: LoginService
    private weak var loginViewDelegate: LoginPresenterDelegate?
    
    init(service: LoginService) {
        self.service = service
        
    }
    
    // MARK: - Private methods 
    func postLogin() {
        
        guard let loginViewDelegate = loginViewDelegate else {
            return
        }
        
        if !FormsUtils.isValidEmail(loginViewDelegate.getEmail()) {
            self.loginViewDelegate?.showError(message: Lang.Login.invalidEmailMessage)
            return
        }
        
        if loginViewDelegate.getPassword().isEmpty {
            self.loginViewDelegate?.showError(message: Lang.Login.invalidPasswordMessage)
            return
        }
        self.loginViewDelegate?.toggleLoader(isEnabled: true)
        
        let loginReq = User(
            email: loginViewDelegate.getEmail(),
            password: loginViewDelegate.getPassword())
        service.postLogin(
            user: loginReq,
            onFinished: { [weak self] isSucces in
                self?.loginViewDelegate?.showLoginResult(result: isSucces)
                self?.loginViewDelegate?.toggleLoader(isEnabled: false)
            })
    }
    
    func setViewDelegate(delegate: LoginPresenterDelegate) {
        self.loginViewDelegate = delegate
    }
}
