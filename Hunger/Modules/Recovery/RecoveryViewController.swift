//
//  RecoveryViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/10/21.
//

import UIKit
import SimpleKeyboard

class RecoveryViewController: UIViewController {
    
    // MARK: - IBoutlets
    @IBOutlet weak var facebookLoginText: UILabel!
    @IBOutlet private weak var recoveryTextField: UITextField!
    @IBOutlet weak var loaderActivityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    private let facebookHighlightText = "FACEBOOK"
    private let recoveryPresenter: RecoveryPresenter
    
    // MARK: - Init required for xib initialization
    
    init(presenter: RecoveryPresenter) {
        self.recoveryPresenter = presenter
        super.init(nibName: String(describing: Self.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        recoveryPresenter.setViewDelegate(delegate: self)
        supportFlexibleLayout()
        setupFacebookText()
        setupGestureToHelpText()
    }
    
    // MARK: - IBActions
    @IBAction private func submitButton() {
        checkEmail()
    }
    
    @objc private func facebookLoginButton() {
        showMessage(alertMessage: Lang.Main.notAvailableError)
    }
    
    @IBAction func backButton() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private methods
    
    private func checkEmail() {
        if let recoveryText = recoveryTextField.text {
            startRecovery(email: recoveryText)
        } else {
            showMessage(alertMessage: Lang.Recovery.errorMessage)
        }
    }
    
    private func setupFacebookText() {
        TextUtils.highlightTextInLabel(
            textToSetup: facebookLoginText,
            textToHighlight: facebookHighlightText,
            color: .blue,
            font: .boldDefaulSize
        )
    }
    
    private func setupGestureToHelpText() {
        facebookLoginText.isUserInteractionEnabled = true
        
        facebookLoginText.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(facebookLoginButton)
            )
        )
    }
}
extension RecoveryViewController: RecoveryPresenterDelegate {
    func toggleLoader(isEnabled: Bool) {
        isEnabled ? loaderActivityIndicatorView.startAnimating() : loaderActivityIndicatorView.stopAnimating()
    }
    
    func getEmail() -> String {
        recoveryTextField.text ?? .init()
    }
    
    func startRecovery(email: String) {
        recoveryPresenter.postRecovery()
    }
    
    func recoveryResult(result: String) {
        showMessage(alertMessage: result)
    }
}
