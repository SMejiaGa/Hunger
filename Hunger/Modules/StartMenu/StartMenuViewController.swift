//
//  MainViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 3/10/21.
//

import UIKit
import Dodo

class StartMenuViewController: UIViewController {
    // MARK: - UI Referencies
    @IBOutlet private weak var emailbutton: UIButton!
    
    // MARK: - Properties
    private let detailSegueId = "showDirectDetail"
    private let emailSegueId = "showEmailLogin"
    
    // MARK: - Init required for xib initialization
    
    init() {
        super.init(nibName: String(describing: StartMenuViewController.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - IBActions
    @IBAction private func checkButton() {
        let listBussines = ListBussines(service: RestaurantService())
        let viewController = ListViewController(bussines: listBussines)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction private func facebookLoginButton() {
        showMessage(alertMessage: Lang.Main.notAvailableError)
    }
    
    @IBAction private func emailLoginButton() {
        let loginBussines = LoginBussines(service: LoginService())
        let viewController = LoginViewController(bussines: loginBussines)
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    // MARK: - private methods
  
}
