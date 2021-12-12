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
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    private let registerHighlightText =  "QUIERO REGISTRARME"
    private let helpHighlightText =  "AYUDA"
    private let presenter: LoginPresenter
    
    // MARK: - Init required for xib initialization
    
    init(presenter: LoginPresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: Self.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        supportFlexibleLayout()
        setupHelpText()
        setupGestureToHelpText()
        setupRegisterText()
        setupGestureToRegisterText()
    }
    
    // MARK: - IBActions
    
    @IBAction private func loginButton() {
        self.presenter.postLogin()
    }
    
    @objc private func helpButton(_ gesture: UITapGestureRecognizer) {
        let recoveryPresenter = RecoveryPresenter(service: RecoveryService())
        let viewController = RecoveryViewController(presenter: recoveryPresenter)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func registerButtonAction(_ gesture: UITapGestureRecognizer) {
        let registerPresenter = RegisterPresenter(service: RegisterService())
        let viewController = RegisterViewController(presenter: registerPresenter)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private methods
    
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

// MARK: - LoginPresenterDelegate

extension LoginViewController: LoginPresenterDelegate {
    func toggleLoader(isEnabled: Bool) {
        isEnabled ? self.loader.startAnimating() : self.loader.stopAnimating()
    }
    
    func showError(message: String) {
        showMessage(alertMessage: message)
    }
    
    func getEmail() -> String {
        emailTextField.text ?? .init()
    }
    
    func getPassword() -> String {
         passwordTextField.text ?? .init()
    }
    
    func showLoginResult(result: Bool) {
        if result {
            DispatchQueue.main.async {
                let restaurantPresenter = ListPresenter(service: RestaurantService())
                let viewController = ListViewController(presenter: restaurantPresenter)
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        } else {
            showMessage(alertMessage: Lang.Login.userNotFound)
        }
    }
}
