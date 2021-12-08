//
//  AboutUsBussines.swift
//  Hunger
//
//  Created by Sebastian Mejia on 24/11/21.
//

import Foundation

final class AboutUsBussines {
 
    private let aboutUsService: AboutUsService
    
    init(aboutUsService: AboutUsService) {
        self.aboutUsService = aboutUsService
    }
    
    func fetchAboutUs(onFinished: @escaping (AboutUsResponse, Bool) -> Void) {
        aboutUsService.getAboutUs(onFinished: { aboutUsData, receivedError in
            onFinished(aboutUsData, receivedError)
        })
    }
}
