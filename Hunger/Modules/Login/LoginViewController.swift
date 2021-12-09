//
//  LoginViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/10/21.
//

import UIKit
import SimpleKeyboard

class LoginViewController: UIViewController {
    // MARK: - UI Referencies
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var helpText: UILabel!
    @IBOutlet private weak var registerText: UILabel!
    
    // MARK: - Properties
    private let registerHighlightText =  "QUIERO REGISTRARME"
    private let helpHighlightText =  "AYUDA"
    private let bussines: LoginBussines
    
    // MARK: - Init required for xib initialization
    
    init(bussines: LoginBussines) {
        self.bussines = bussines
        super.init(nibName: String(describing: LoginViewController.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        supportFlexibleLayout()
        setupHelpText()
        setupGestureToHelpText()
        setupRegisterText()
        setupGestureToRegisterText()
    }
    
    // MARK: - IBActions
    @IBAction private func loginButton() {
        performLogin()
    }
    
    @objc private func helpButton(_ gesture: UITapGestureRecognizer) {
        let recoveryBussines = RecoveryBussines(service: RecoveryService())
        let viewController = RecoveryViewController(bussines: recoveryBussines)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func registerButtonAction(_ gesture: UITapGestureRecognizer) {
        let registerBussines = RegisterBussines(service: RegisterService())
        let viewController = RegisterViewController(bussines: registerBussines)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private methods
    private func performLogin() {
        let userEmail = emailTextField.text ?? ""
        let userPassword = passwordTextField.text ?? ""
        
        if FormsUtils.isValidEmail(userEmail) && !userPassword.isEmpty {
            bussines.postLogin(
                email: userEmail,
                password: userPassword,
                onFinishedBussines: {  [weak self] succesFromService in
                    guard let self = self else { return }
                    
                DispatchQueue.main.async {
                    if succesFromService == true {
                       let restaurantBussines = ListBussines(service: RestaurantService())
                        let viewController = ListViewController(bussines: restaurantBussines)
                        self.navigationController?.pushViewController(viewController, animated: true)
                    } else {
                        self.showMessage(alertMessage: Lang.Login.invalidLogIn)
                    }
                }
            })
        } else {
            showMessage(alertMessage: Lang.Login.invalidEmailMessage)
        }
    }
    
    private func setupHelpText() {
        TextUtils.highlightTextInLabel(
            textToSetup: helpText,
            textToHighlight: helpHighlightText,
            color: .green,
            font: .boldDefaulSize
        )
    }
    
    private func setupGestureToHelpText() {
        TextUtils.setupTapGesture(
            target: self,
            textToSetup: helpText,
            onTapAction: #selector(helpButton)
        )
    }
    
    private func setupRegisterText() {
        TextUtils.highlightTextInLabel(
            textToSetup: registerText,
            textToHighlight: registerHighlightText,
            color: .blue,
            font: .boldDefaulSize
        )
    }
    
    private func setupGestureToRegisterText() {
        TextUtils.setupTapGesture(
            target: self,
            textToSetup: registerText,
            onTapAction: #selector(registerButtonAction)
        )
    }
}
