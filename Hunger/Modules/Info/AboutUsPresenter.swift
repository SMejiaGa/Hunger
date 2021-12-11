//
//  AboutUsPresenter.swift
//  Hunger
//
//  Created by Sebastian Mejia on 24/11/21.
//

import Foundation

protocol AboutUsPresenterDelegate: AnyObject {
    func fetchInfo(data: AboutUsResponse)
    func showError()
}

final class AboutUsPresenter {
 
    private let service: AboutUsService
    private weak var aboutUsViewDelegate: AboutUsPresenterDelegate?
    
    init(service: AboutUsService) {
        self.service = service
    }
    
    func fetchAboutUs() {
        service.getAboutUs(onFinished: { [weak self] aboutUsData, receivedError in
            if !receivedError {
                self?.aboutUsViewDelegate?.fetchInfo(data: aboutUsData)
            } else {
                self?.aboutUsViewDelegate?.showError()
            }
        })
    }
    
    func setViewDelegate(delegate: AboutUsPresenterDelegate) {
        self.aboutUsViewDelegate = delegate
    }
}
