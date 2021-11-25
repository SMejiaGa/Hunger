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
    private var shareText = "Ven a conocer este nuevo restaurante:"
    
    // MARK: - IBOutlets
    @IBOutlet private weak var restaurantRatingLabel: UILabel!
    @IBOutlet private weak var restaurantAdressLabel: UILabel!
    @IBOutlet weak var restaurantIsOpenLabel: UILabel!
    @IBOutlet private weak var restaurantIsFav: UIImageView!
    @IBOutlet private weak var restaurantNameLabel: UILabel!
    @IBOutlet private weak var restaurantIsOpen: UIImageView!
    @IBOutlet private weak var restaurantCommentsLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet var starsImages: [UIImageView]!
    // MARK: - IBActions
    
    @IBAction func backButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareButton() {
            let textToShare = [ shareText ]
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
                print("something went wrong")
            } else {
                DispatchQueue.main.async {
                    self.shareText += " \(detailData.name)!\n -Queda en: \(detailData.address) "
                    self.loader.stopAnimating()
                    self.restaurantRatingLabel.text = "\(String(format: "%.1f", detailData.rating?.average ?? 0))/10"
                    self.restaurantCommentsLabel.text = "\(detailData.commentsCount) COMENTARIOS"
                    self.restaurantAdressLabel.text = "\(detailData.address)"
                    self.restaurantNameLabel.text = "\(detailData.name)"
                    if detailData.isFavorite {
                        self.restaurantIsFav.image = UIImage(named: "favIconOnIcon")
                    }
                    if detailData.isOpen {
                        self.restaurantIsOpenLabel.text = "ABIERTO"
                        self.restaurantIsOpen.image = UIImage(named: "availableIcon")
                    } else {
                        self.restaurantIsOpenLabel.text = "CERRADO"
                        self.restaurantIsOpen.image = UIImage(named: "unavailableIcon")
                    }
                    self.lightStars(actualStars: detailData.stars)
                }
            }
        })
    }
    
    private func lightStars(actualStars: Int) {
        for star in 0...actualStars {
            starsImages[star].image = UIImage(named: "starIcon")
        }
    }

}
