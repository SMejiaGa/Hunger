//
//  RecoveryViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/10/21.
//

import UIKit

class RecoveryViewController: UIViewController {
    
    //MARK: - IBoutlets
    @IBOutlet private weak var recoveryTextField: UITextField!
    @IBOutlet weak var facebookLoginText: UILabel!
    
    //MARK: - Properties
    private let facebookHighlightText = "FACEBOOK"
    
    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFacebookText()
        setupGestureToHelpText()
    }
    
    //MARK: - IBActions
    @IBAction private func submitButton() {
        checkEmail()
    }
    
    @objc private func facebookLoginButton() {
        showMessage(alertMessage: Lang.Main.notAvailableError)
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Private methods
    private func checkEmail(){
        if recoveryTextField.text != nil{
            showMessage(alertMessage: Lang.Recovery.alertMessage)
        }else{
            showMessage(alertMessage: Lang.Recovery.errorMessage)
        }
    }
    
    private func setupFacebookText() {
        TextUtils.highlightTextInLabel(textToSetup: facebookLoginText, textToHighlight: facebookHighlightText, color: .blue, font: .boldDefaulSize)
    }
    
    private func setupGestureToHelpText() {
       // TextUtils.setupTapGesture(target: <#T##Any#>, textToSetup: <#T##UILabel#>, onTapAction: <#T##Selector#>)
        facebookLoginText.isUserInteractionEnabled = true
        facebookLoginText.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(facebookLoginButton)))
    }
}
