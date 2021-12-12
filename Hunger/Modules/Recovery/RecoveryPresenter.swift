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
    func getEmail() -> String
    func toggleLoader(isEnabled: Bool)
}

final class RecoveryPresenter {
    private let service: RecoveryService
    private weak var recoveryViewDelegate: RecoveryPresenterDelegate?
    
    init(service: RecoveryService) {
        self.service = service
    }
    
    func postRecovery() {
        guard let recoveryViewDelegate = recoveryViewDelegate else {
            return
        }
        recoveryViewDelegate.toggleLoader(isEnabled: true)

        let emailToRecover = Email(email: recoveryViewDelegate.getEmail())
        service.postRecovery(email: emailToRecover) { [weak self] messageFromWeb in
            self?.recoveryViewDelegate?.toggleLoader(isEnabled: false)
            self?.recoveryViewDelegate?.recoveryResult(result: messageFromWeb)
        }
    }
    
    func setViewDelegate(delegate: RecoveryPresenterDelegate) {
        self.recoveryViewDelegate = delegate
    }
}
