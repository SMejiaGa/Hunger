//
//  RestaurantDetailViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 22/11/21.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    // MARK: - Properties
    var restaurantToFindID: Int?
    private var bussines = DetailBussines()
    private var shareText = "Ven a conocer este nuevo restaurante:"
    
    // MARK: - IBOutlets
    @IBOutlet private weak var restaurantRatingLabel: UILabel!
    @IBOutlet private weak var restaurantAdressLabel: UILabel!
    @IBOutlet private weak var restaurantIsOpenLabel: UILabel!
    @IBOutlet private weak var restaurantIsFavImage: UIImageView!
    @IBOutlet private weak var restaurantNameLabel: UILabel!
    @IBOutlet private weak var restaurantIsOpenImage: UIImageView!
    @IBOutlet private weak var restaurantCommentsLabel: UILabel!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    @IBOutlet private var starsImagesColection: [UIImageView]!
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
        bussines.fetchDetails(restaurantToFindID: restaurantToFindID, onFinished: { detailData, errorIn in
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
                        self.restaurantIsFavImage.image = UIImage(named: "favIconOnIcon")
                    }
                    if detailData.isOpen {
                        self.restaurantIsOpenLabel.text = "ABIERTO"
                        self.restaurantIsOpenImage.image = UIImage(named: "availableIcon")
                    } else {
                        self.restaurantIsOpenLabel.text = "CERRADO"
                        self.restaurantIsOpenImage.image = UIImage(named: "unavailableIcon")
                    }
                    self.lightStars(actualStars: detailData.stars)
                }
            }
        })
    }
    
    private func lightStars(actualStars: Int) {
        for star in 0...actualStars {
            starsImagesColection[star].image = UIImage(named: "starIcon")
        }
    }

}