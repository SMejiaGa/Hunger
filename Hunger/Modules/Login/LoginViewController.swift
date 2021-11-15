//
//  LoginViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/10/21.
//

import UIKit
import SimpleKeyboard

enum AppRoutes {
    enum Login: String {
        case help = "showHelp"
        case register = "showRegister"
        case list = "ShowDetailList"
    }
}
/// Esto no es una buena practica deberia utilizar un navigationController, pero como usos segues, lo manejo asi
class Router {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func route(destination: AppRoutes.Login) {
        viewController?.performSegue(withIdentifier: destination.rawValue, sender: nil)
    }
}

class LoginViewController: UIViewController {
    // MARK: - UI Referencies
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var helpText: UILabel!
    @IBOutlet private weak var registerText: UILabel!
    
    // MARK: - Properties
    private let helpSegueId = "showHelp"
    private let registerSegueId = "showRegister"
    private let detailSegueId =  "ShowDetailList"
    private let registerHighlightText =  "QUIERO REGISTRARME"
    private let helpHighlightText =  "AYUDA"
    private let loginBussines = LoginBussines()
    private var router: Router?
    
    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        supportFlexibleLayout()
        setupHelpText()
        setupGestureToHelpText()
        setupRegisterText()
        setupGestureToRegisterText()
        setupRouter()
    }
    
    // MARK: - IBActions
    @IBAction private func loginButton() {
        performLogin()
    }
    
    @objc private func helpButton(_ gesture: UITapGestureRecognizer) {
        performSegue(withIdentifier: helpSegueId, sender: nil)
    }
    
    @objc func registerButtonAction(_ gesture: UITapGestureRecognizer) {
        router?.route(destination: .register)
    }
    
    @IBAction private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private methods
    private func performLogin() {
        let userEmail = emailTextField.text ?? ""
        let userPassword = passwordTextField.text ?? ""
        
        if FormsUtils.isValidEmail(userEmail) && !userPassword.isEmpty {
            loginBussines.postLogin(
                email: userEmail,
                password: userPassword,
                onFinishedBussines: { succesFromService in
                DispatchQueue.main.async {
                    if succesFromService == true {
                        self.performSegue(withIdentifier: self.detailSegueId, sender: nil)
                    } else {
                        self.showMessage(alertMessage: Lang.Login.invalidLogIn)
                    }
                }
            })
        } else {
            showMessage(alertMessage: Lang.Login.invalidEmailMessage)
        }
    }
    
    private func setupRouter() {
        router = Router(viewController: self)
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
