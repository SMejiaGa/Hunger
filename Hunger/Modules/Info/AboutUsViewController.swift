//
//  AboutUsViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/10/21.
//

import UIKit

class AboutUsViewController: UIViewController {
    // MARK: - Properties
    private let legalBussines = AboutUsBussines()

    // MARK: - IBOutlets
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    @IBOutlet private weak var legalTextView: UITextView!
    
    // MARK: - IBActions
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLegal()
    }
    
    // MARK: - Private Functions
    private func fetchLegal() {
        legalBussines.fetchLegal { legalData, errorExist in
            if errorExist {
                print("Something went wrong")
            } else {
                DispatchQueue.main.async {
                    self.loader.stopAnimating()
                    self.legalTextView.attributedText = legalData.text.htmlToAttributedString
                }
            }
        }
    }
}
