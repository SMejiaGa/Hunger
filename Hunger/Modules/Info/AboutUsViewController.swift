//
//  AboutUsViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/10/21.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    private let legalBussines = AboutUsBussines()

    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var legalText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLegal()
    }
    
    private func fetchLegal() {
        legalBussines.fetchLegal { legalData, errorExist in
            if errorExist {
                print("Something went wrong")
            } else {
                DispatchQueue.main.async {
                    self.loader.stopAnimating()
                    self.legalText.attributedText = legalData.text.htmlToAttributedString
                }
            }
        }
    }
}
