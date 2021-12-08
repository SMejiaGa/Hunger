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
    @IBOutlet private weak var recoveryTextField: UITextField!
    @IBOutlet weak var facebookLoginText: UILabel!
    
    // MARK: - Properties
    private let facebookHighlightText = "FACEBOOK"
    private let recoveryBussines: RecoveryBussines
    
    // MARK: - Init required for xib initialization
    
    init(recoveryBussines: RecoveryBussines) {
        self.recoveryBussines = recoveryBussines
        super.init(nibName: "RecoveryViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    private func recoverEmail(email: String) {
        recoveryBussines.postRecovery(
            emailFromUser: email,
            onFinished: { [weak self] messageFromWeb in
            self?.showMessage(alertMessage: messageFromWeb)
        })
    }
    
    private func checkEmail() {
        if recoveryTextField.text != nil {
            recoverEmail(email: recoveryTextField.text ?? "")
        } else {
            showMessage(alertMessage: Lang.Recovery.errorMessage)
        }
    }
    
    private func setupFacebookText() {
        TextUtils.highlightTextInLabel(textToSetup: facebookLoginText, textToHighlight: facebookHighlightText, color: .blue, font: .boldDefaulSize)
    }
    
    private func setupGestureToHelpText() {
        facebookLoginText.isUserInteractionEnabled = true
        facebookLoginText.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(facebookLoginButton)))
    }
}
