//
//  RecoveryBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 1/11/21.
//

import Foundation

final class RecoveryBussines {
    let service: RecoveryService
    
    init(service: RecoveryService) {
        self.service = service
    }
    
    func postRecovery(emailFromUser: String, onFinished: @escaping (String) -> Void) {
        let emailToRecover = Email(email: emailFromUser)
        service.postRecovery(email: emailToRecover) { messageFromWeb in
            onFinished(messageFromWeb)
        }
    }
}
