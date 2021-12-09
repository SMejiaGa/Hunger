//
//  AboutUsViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/10/21.
//

import UIKit

class AboutUsViewController: UIViewController {
    // MARK: - Properties
    private let bussines: AboutUsBussines

    // MARK: - IBOutlets
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    @IBOutlet private weak var aboutUsTextView: UITextView!
    
    // MARK: - IBActions
    @IBAction private func backButton() {
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Init required for xib initialization
    
    init(bussines: AboutUsBussines) {
        self.bussines = bussines
        
        super.init(nibName: String(describing: AboutUsViewController.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAboutUs()
    }
    
    // MARK: - Private Functions
    private func fetchAboutUs() {
        bussines.fetchAboutUs { aboutUsData, errorExist in
            if errorExist {
                self.showMessage(alertMessage: Lang.Error.commonError)
            } else {
                DispatchQueue.main.async {
                    self.loader.stopAnimating()
                    self.aboutUsTextView.attributedText = aboutUsData.text.htmlToAttributedString
                }
            }
        }
    }
}
