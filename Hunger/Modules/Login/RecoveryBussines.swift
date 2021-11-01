//
//  RecoveryBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 1/11/21.
//

import Foundation

class RecoveryBussines {
    let webService = WebService()
    
    func postRecovery(emailFromUser: String, onFinished: @escaping (String) -> Void) {
        let emailToRecover = Email(email: emailFromUser)
        webService.postRecovery(email: emailToRecover) { messageFromWeb in
            onFinished(messageFromWeb)
        }
    }
}
