//
//  MainViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 3/10/21.
//

import UIKit
import Dodo

class MainViewController: UIViewController {
    // MARK: - UI Referencies
    @IBOutlet private weak var emailbutton: UIButton!
    
    // MARK: - Properties
    private let detailSegueId = "showDirectDetail"
    private let emailSegueId = "showEmailLogin"
    
    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    @IBAction private func checkButton() {
        performSegue(withIdentifier: detailSegueId, sender: nil)
    }
    
    @IBAction private func facebookLoginButton() {
        showMessage(alertMessage: Lang.Main.notAvailableError)
    }
    
    @IBAction private func emailLoginButton() {
        performSegue(withIdentifier: emailSegueId, sender: nil)
    }
    
    // MARK: - private methods
  
}
