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
    private let recoveryPresenter: RecoveryPresenter
    
    // MARK: - Init required for xib initialization
    
    init(presenter: RecoveryPresenter) {
        self.recoveryPresenter = presenter
        super.init(nibName: String(describing: RecoveryViewController.self), bundle: .main)
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
        if recoveryTextField.text != nil {
            startRecovery(email: recoveryTextField.text ?? "")
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
extension RecoveryViewController: RecoveryPresenterDelegate {
    func startRecovery(email: String) {
        recoveryPresenter.postRecovery(
            emailFromUser: email)
    }
    
    func recoveryResult(result: String) {
        showMessage(alertMessage: result)
    }
}
