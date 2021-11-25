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
    let shareText = "Ven a conocer este nuevo restaurante!"
    
    // MARK: - IBOutlets
    @IBOutlet private weak var restaurantRatingLabel: UILabel!
    @IBOutlet private weak var restaurantAdressLabel: UILabel!
    @IBOutlet private weak var restaurantIsFav: UIImageView!
    @IBOutlet private weak var restaurantNameLabel: UILabel!
    @IBOutlet private weak var restaurantIsOpen: UIImageView!
    @IBOutlet private weak var restaurantCommentsLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var star1Icon: UIImageView!
    @IBOutlet weak var star2Icon: UIImageView!
    @IBOutlet weak var star3Icon: UIImageView!
    @IBOutlet weak var star4Icon: UIImageView!
    @IBOutlet weak var star5Icon: UIImageView!
    // MARK: - IBActions
    @IBAction func backButton() {
        navigationController?.dismiss(animated: true)
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
                    self.loader.stopAnimating()
                    self.restaurantRatingLabel.text = "\(detailData.rating?.average ?? 0)" 
                    self.restaurantCommentsLabel.text = "\(detailData.commentsCount)"
                    self.restaurantAdressLabel.text = "\(detailData.adress)"
                    self.restaurantNameLabel.text = "\(detailData.name)"
                    self.restaurantAdressLabel.text = "\(detailData.adress)"
                    if detailData.isFavorite {
                        self.restaurantIsFav.image = UIImage(named: "favIconOnIcon")
                    }
                    self.lightStars(actualStars: detailData.stars)
                }
            }
        })
    }
    
    private func lightStars(actualStars: Int) {
        if actualStars >= 1 {
            star1Icon.image = UIImage(named: "starIcon")
            if actualStars >= 2 {
                star2Icon.image = UIImage(named: "starIcon")
                if actualStars >= 3 {
                    star3Icon.image = UIImage(named: "starIcon")
                    if actualStars >= 4 {
                        star4Icon.image = UIImage(named: "starIcon")
                        if actualStars >= 5 {
                            star5Icon.image = UIImage(named: "starIcon")
                        }
                    }
                }
            }
        }
    }

}
