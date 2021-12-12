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
    private let highlightText = "INGRESAR"
    private let presenter: RegisterPresenter
    
    // MARK: - Init required for xib initialization
    
    init(presenter: RegisterPresenter) {
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
        setupRegisterText()
        setupGestureToRegisterText()
    }
    
    // MARK: - IBActions
    @IBAction private func submitButton() {
        presenter.postRegister()
    }
    
    @objc private func sendToLogin(_ gesture: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Private methods
    
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

extension RegisterViewController: RegisterPresenterDelegate {
    func showError(message: String) {
        showMessage(alertMessage: message)
    }
    
    func showRegisterResult(result: Bool) {
        if result == true {
            let loginPresenter = LoginPresenter(service: LoginService())
             let viewController = LoginViewController(presenter: loginPresenter)
             self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            self.showMessage(alertMessage: Lang.Register.errorMessage)
        }
    }
    
    func getEmail() -> String {
        return registeredEmailTextField.text ?? ""
    }
    
    func getPassword() -> String {
        return passwordTextField.text ?? ""
    }
}
