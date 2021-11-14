//
//  RecoveryBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 1/11/21.
//

import Foundation

final class RecoveryBussines {
    let recoveryService = RecoveryService()
    
    func postRecovery(emailFromUser: String, onFinished: @escaping (String) -> Void) {
        let emailToRecover = Email(email: emailFromUser)
        recoveryService.postRecovery(email: emailToRecover) { messageFromWeb in
            onFinished(messageFromWeb)
        }
    }
}
