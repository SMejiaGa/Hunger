//
//  AboutUsViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/10/21.
//

import UIKit

class AboutUsViewController: UIViewController {
    // MARK: - Properties
    private let aboutUsBussines = AboutUsBussines()

    // MARK: - IBOutlets
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    @IBOutlet private weak var aboutUsTextView: UITextView!
    
    // MARK: - IBActions
    @IBAction private func backButton() {
        navigationController?.popViewController(animated: true)
    }
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAboutUs()
    }
    
    // MARK: - Private Functions
    private func fetchAboutUs() {
        aboutUsBussines.fetchAboutUs { aboutUsData, errorExist in
            if errorExist {
                self.showMessage(alertMessage: Lang.ErrorMessages.tryAgainLaterError)
            } else {
                DispatchQueue.main.async {
                    self.loader.stopAnimating()
                    self.aboutUsTextView.attributedText = aboutUsData.text.htmlToAttributedString
                }
            }
        }
    }
}
