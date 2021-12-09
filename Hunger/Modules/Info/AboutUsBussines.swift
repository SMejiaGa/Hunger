//
//  AboutUsBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 24/11/21.
//

import Foundation

final class AboutUsBussines {
 
    private let aboutUsService: AboutUsService
    
    init(service: AboutUsService) {
        self.aboutUsService = service
    }
    
    func fetchAboutUs(onFinished: @escaping (AboutUsResponse, Bool) -> Void) {
        aboutUsService.getAboutUs(onFinished: { aboutUsData, receivedError in
            onFinished(aboutUsData, receivedError)
        })
    }
}
