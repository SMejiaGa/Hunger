//
//  RegisterViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/10/21.
//

import UIKit
import Dodo
import SimpleKeyboard

class RegisterViewController: UIViewController {
    
    // MARK: - UI References
    @IBOutlet private weak var namesTextField: UITextField!
    @IBOutlet private weak var registeredEmailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet weak var alreadyHaveAnAccount: UILabel!
    
    // MARK: - Properties
    private let detailSegueId = "ShowDetailList"
    private let highlightText = "INGRESAR"
    private let registerBussines: RegisterBussines
    
    // MARK: - Init required for xib initialization
    
    init(registerBussines: RegisterBussines) {
        self.registerBussines = registerBussines
        super.init(nibName: "RegisterViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        supportFlexibleLayout()
        setupRegisterText()
        setupGestureToRegisterText()
    }
    
    // MARK: - IBActions
    @IBAction private func submitButton() {
        performRegister()
    }
    
    @objc private func sendToLogin(_ gesture: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Private methods
    private func performRegister() {
        let passwordToRegister = passwordTextField.text ?? ""
        let isValidPasswordLengh = passwordToRegister.count > 3
        let emailToRegister = registeredEmailTextField.text ?? ""
        let detailSegueIdCaptured = detailSegueId
        
        if FormsUtils.isValidEmail(emailToRegister), isValidPasswordLengh {
            registerBussines.postRegister(
                email: emailToRegister,
                password: passwordToRegister,
                onFinished: { succesFromService in
                DispatchQueue.main.async { [weak self] in
                    if succesFromService == true {
                        self?.performSegue(withIdentifier: detailSegueIdCaptured, sender: nil)
                    } else {
                        self?.showMessage(alertMessage: Lang.Register.errorMessage)
                    }
                }
            })
        } else {
            self.showMessage(alertMessage: Lang.Register.alertMessage)
        }
    }
    
    private func setupRegisterText() {
        TextUtils.highlightTextInLabel(
            textToSetup: alreadyHaveAnAccount,
            textToHighlight: highlightText,
            color: .blue,
            font: .boldDefaulSize
        )
    }
    
    private func setupGestureToRegisterText() {
        TextUtils.setupTapGesture(
            target: self,
            textToSetup: alreadyHaveAnAccount,
            onTapAction: #selector(sendToLogin)
        )
    }
}
