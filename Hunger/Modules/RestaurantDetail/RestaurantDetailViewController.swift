//
//  RestaurantDetailViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 22/11/21.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    var onClickCell = 1
    private var bussines = DetailBussines()
    
    // MARK: - IBOutlets
    @IBOutlet private weak var restaurantRatingLabel: UILabel!
    @IBOutlet private weak var restaurantAdressLabel: UILabel!
    @IBOutlet private weak var restaurantIsFav: UIImageView!
    @IBOutlet private weak var restaurantNameLabel: UILabel!
    @IBOutlet private weak var restaurantIsOpen: UIImageView!
    @IBOutlet private weak var restaurantCommentsLabel: UILabel!
    
    // MARK: - IBActions
    @IBAction func backButton() {
        navigationController?.dismiss(animated: true)
    }
    
    @IBAction func shareButton() {
        let text = "Ven a conocer este nuevo restaurante!"
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRestaurant()
    }
    
    // MARK: - Private functions
    
    private func fetchRestaurant() {
        bussines.fetchDetails(onFinished: { detailData, errorIn in
            if errorIn {
                
            } else {
                self.restaurantRatingLabel.text = "\(detailData.stars)"
                self.restaurantCommentsLabel.text = "\(detailData.commentsCount)"
                self.restaurantAdressLabel.text = "\(detailData.adress)"
                self.restaurantNameLabel.text = "\(detailData.name)"
                self.restaurantAdressLabel.text = "\(detailData.adress)"
                if detailData.isFavorite {
                    self.restaurantIsFav.image = UIImage(named: "favIconOnIcon")
                }
            }
        })
    }

}
