//
//  RegisterViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/10/21.
//

import UIKit
import Dodo

class RegisterViewController: UIViewController {
    
    // MARK: -UI References
    @IBOutlet private weak var namesTextField: UITextField!
    @IBOutlet private weak var registeredEmailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet weak var alreadyHaveAnAccount: UILabel!
    
    // MARK: - Properties
    private let detailSegueId = "ShowDetailList"
    private let highlightText = "INGRESAR"
    
    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    private func performRegister(){
        let isValidPasswordLengh = passwordTextField.text?.count ?? 0 > 3
        
        if FormsUtils.isValidEmail(registeredEmailTextField.text ?? ""), isValidPasswordLengh {
            performSegue(withIdentifier: detailSegueId, sender: nil)
            return
        }
        
        showMessage(alertMessage: Lang.Register.alertMeesage)
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
