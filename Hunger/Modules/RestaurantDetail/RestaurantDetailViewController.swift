//
//  RestaurantDetailViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 22/11/21.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let presenter: DetailPresenter
    private var shareText = Lang.DetailView.shareMessage
    private var restaurantIsOpenText = "ABIERTO"
    private var restaurantIsClosedText = "CERRADO"
    
    // MARK: - IBOutlets
    @IBOutlet private weak var restaurantRatingLabel: UILabel!
    @IBOutlet private weak var restaurantAdressLabel: UILabel!
    @IBOutlet private weak var restaurantIsOpenLabel: UILabel!
    @IBOutlet private weak var restaurantIsFavImage: UIImageView!
    @IBOutlet private weak var restaurantNameLabel: UILabel!
    @IBOutlet private weak var restaurantIsOpenImage: UIImageView!
    @IBOutlet private weak var restaurantCommentsLabel: UILabel!
    @IBOutlet private weak var loaderActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private var starsImagesColection: [UIImageView]!
    // MARK: - IBActions
    
    @IBAction private func backButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func shareButton() {
        let textToShare = [ shareText ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: - Init required for xib initialization
    
    init(presenter: DetailPresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: Self.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchRestaurant()
    }
    
    // MARK: - Private functions
    
    private func fetchRestaurant() {
        presenter.fetchDetails()
    }
    
    private func lightStars(actualStars: Int) {
        for star in 0...actualStars {
            starsImagesColection[star].image = UIImage(named: "starIcon")
        }
    }

}

extension RestaurantDetailViewController: DetailPresenterDelegate {
    func toggleloader(isEnabled: Bool) {
        isEnabled ? loaderActivityIndicatorView.startAnimating() : loaderActivityIndicatorView.stopAnimating()
    }
    
    func setDetails(detailData: RestaurantDetail) {
        let restaurantName = detailData.name
        let restaurantAdress = detailData.address
        let localizedText = " %@! \n -Queda en: %@"
        let formatedText = String(format: localizedText, "\(restaurantName)", "\(restaurantAdress)")
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.shareText += formatedText
                self.loaderActivityIndicatorView.stopAnimating()
                self.restaurantRatingLabel.text = "\(String(format: "%.1f", detailData.rating?.average ?? 0))/10"
                self.restaurantCommentsLabel.text = "\(detailData.commentsCount) \(Lang.DetailView.comentsMessage)"
                self.restaurantAdressLabel.text = "\(detailData.address)"
                self.restaurantNameLabel.text = "\(detailData.name)"
                if detailData.isFavorite {
                    self.restaurantIsFavImage.image = UIImage(named: "favIconOnIcon")
                }
                if detailData.isOpen {
                    self.restaurantIsOpenLabel.text = self.restaurantIsOpenText
                    self.restaurantIsOpenImage.image = UIImage(named: "availableIcon")
                } else {
                    self.restaurantIsOpenLabel.text = self.restaurantIsClosedText
                    self.restaurantIsOpenImage.image = UIImage(named: "unavailableIcon")
                }
                self.lightStars(actualStars: detailData.stars)
            
        }
    }
    
    func restaurantError() {
        showMessage(alertMessage: Lang.Error.commonError)
    }
    
}
