//
//  RecoveryPresenter.swift
//  Hunger
//
//  Created by Sebastian Mejia on 1/11/21.
//

import Foundation

protocol RecoveryPresenterDelegate: AnyObject {
    func startRecovery(email: String)
    func recoveryResult(result: String)
}

final class RecoveryPresenter {
    private let service: RecoveryService
    private weak var recoveryViewDelegate: RecoveryPresenterDelegate?
    
    init(service: RecoveryService) {
        self.service = service
    }
    
    func postRecovery(emailFromUser: String) {
        let emailToRecover = Email(email: emailFromUser)
        service.postRecovery(email: emailToRecover) { [weak self] messageFromWeb in
            self?.recoveryViewDelegate?.recoveryResult(result: messageFromWeb)
        }
    }
    
    func setViewDelegate(delegate: RecoveryPresenterDelegate) {
        self.recoveryViewDelegate = delegate
    }
}
