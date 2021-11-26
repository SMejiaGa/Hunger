//
//  AboutUsBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 24/11/21.
//

import Foundation

final class AboutUsBussines {
 
    private let legalService = AboutUsService()
    
    func fetchLegal(onFinished: @escaping (LegalResponse, Bool) -> Void) {
        legalService.getLegal(onFinished: { legalData, receivedError in
            onFinished(legalData, receivedError)
        })
    }
}
