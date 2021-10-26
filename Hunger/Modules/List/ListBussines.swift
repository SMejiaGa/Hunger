//
//  ListBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 19/10/21.
//

import Foundation

class ListBussines {
    
    // MARK: -Properties
    private(set) var messageCarrier = [Message]()
    private let webService = WebService()
    
    // MARK: -Private methods
    
    func fetchMessages(onFinished: @escaping () ->Void){
        webService.fetchMessages(onFinished: { usersFromService in
            self.messageCarrier = usersFromService
            onFinished()
        })
    }
}
