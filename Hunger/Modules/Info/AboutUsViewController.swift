//
//  AboutUsViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/10/21.
//

import UIKit

class AboutUsViewController: UIViewController {
    // MARK: - Properties
    private let presenter: AboutUsPresenter

    // MARK: - IBOutlets
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    @IBOutlet private weak var aboutUsTextView: UITextView!
    
    // MARK: - IBActions
    @IBAction private func backButton() {
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Init required for xib initialization
    
    init(presenter: AboutUsPresenter) {
        self.presenter = presenter
        
        super.init(nibName: String(describing: Self.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        presenter.fetchAboutUs()
        
    }
    
}

extension AboutUsViewController: AboutUsPresenterDelegate {
    
    func infoReceived(data: AboutUsResponse) {
        DispatchQueue.main.async {
            self.aboutUsTextView.attributedText = data.text.htmlToAttributedString
        }
    }
    
    func showError() {
        self.showMessage(alertMessage: Lang.Error.commonError)
    }
    
    func toggleLoader(isEnabled: Bool) {
        isEnabled ? loader.startAnimating() : loader.stopAnimating()
    }
}
