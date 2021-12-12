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
    
    // MARK: - Init required for xib initialization
    
    init() {
        super.init(nibName: String(describing: Self.self), bundle: .main)
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
        let listPresenter = ListPresenter(service: RestaurantService())
        let viewController = ListViewController(presenter: listPresenter)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction private func facebookLoginButton() {
        showMessage(alertMessage: Lang.Main.notAvailableError)
    }
    
    @IBAction private func emailLoginButton() {
        let loginPresenter = LoginPresenter(service: LoginService())
        let viewController = LoginViewController(presenter: loginPresenter)
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    // MARK: - private methods
  
}
