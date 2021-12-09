//
//  AboutUsBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 24/11/21.
//

import Foundation

final class AboutUsBussines {
 
    private let service: AboutUsService
    
    init(service: AboutUsService) {
        self.service = service
    }
    
    func fetchAboutUs(onFinished: @escaping (AboutUsResponse, Bool) -> Void) {
        service.getAboutUs(onFinished: { aboutUsData, receivedError in
            onFinished(aboutUsData, receivedError)
        })
    }
}
