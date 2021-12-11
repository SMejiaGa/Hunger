//
//  RegisterPresenter.swift
//  Hunger
//
//  Created by Sebastian Mejia on 28/10/21.
//

import Foundation

protocol RegisterPresenterDelegate: AnyObject {
    func showError(message: String)
    func showRegisterResult(result: Bool)
    func getEmail() -> String
    func getPassword() -> String
}

final class RegisterPresenter {
    private let service: RegisterService
    private weak var registerViewDelegate: RegisterPresenterDelegate?
    
    init(service: RegisterService) {
        self.service = service
    }
    
    func postRegister() {
        guard let registerDelegate = registerViewDelegate else {
            return
        }
        
        if !FormsUtils.isValidEmail(registerDelegate.getEmail()) {
            registerDelegate.showError(message: Lang.Login.invalidEmailMessage)
            return
        }
        
        let loginReq = User(
            email: registerDelegate.getEmail(),
            password: registerDelegate.getPassword()
        )
        service.postRegister(
            user: loginReq,
            onFinished: { [weak self] isSucces in
                self?.registerViewDelegate?.showRegisterResult(result: isSucces)
            }
        )
        
    }
    
    func setViewDelegate(delegate: RegisterPresenterDelegate) {
        self.registerViewDelegate = delegate
    }
}
