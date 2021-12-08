//
//  ListViewController.swift
//  Hunger
//
//  Created by Sebastian Mejia on 2/10/21.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: - Properties
    private let customCellView = UINib(nibName: "CustomTableViewCell",
                                       bundle: nil)
    private let bussines: ListBussines
    private let cellIdentifier = "CustomTableViewCell"
    private let cellReuseIdentifier = "myCell"
    private let descriptionToHighlightA = "buena comida"
    private let descriptionToHighlightB = "precio justo"
    private let showMapSegue = "showMapSegue"
    private let detailCheckSegue = "detailCheckSegue"
    private let highlightTextSize: CGFloat = 19
    private var slideMenuActive = false
    private var restaurantIDToFind: Int?
    private let aboutUsSegue = "showAboutUsSegue"
    private let notFoundSegue = "ShowNotFound"
    
    // MARK: - IBOutlets
    @IBOutlet private weak var restaurantTable: UITableView!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    @IBOutlet private weak var descriptionText: UILabel!
    
    // MARK: - Init required for xib initialization
    
    init(bussines: ListBussines) {
        self.bussines = bussines
        
        super.init(nibName: "ListViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupTableView()
        setupDescriptionText()
    }
    
    // MARK: - IBActions
    
    @IBAction private func backButton() {
        navigationController?.popViewController(animated: true)
    }
   
    @IBAction private func showAlertButton() {
        let mapBussines = MapBussines(restaurantLocationService: MapService())
        let mapViewController = MapViewController(mapBussines: mapBussines)
        let aboutUsBussines = AboutUsBussines(aboutUsService: AboutUsService())
        let aboutUsViewController = AboutUsViewController(aboutUsBussines: aboutUsBussines)
        
        let alert = UIAlertController(title: Lang.List.chooseAnOptionMessage, message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: Lang.List.showMapLabelMessage, style: .default, handler: { _ in
            self.navigationController?.pushViewController(mapViewController, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: Lang.List.aboutUsMessage, style: .default, handler: { _ in
            self.navigationController?.pushViewController(aboutUsViewController, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: Lang.List.logoutMessage, style: .destructive, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: Lang.List.cancelMessage, style: .cancel, handler: {_ in
            }))
        self.present(alert, animated: true, completion: {
        })
    }
    
    // MARK: - Private methods
    private func fetchData() {
        let notFoundViewController = NotFoundViewController()
        bussines.fetchRestaurants(onFinished: { [weak self] errorExist in
            guard let self = self else { return }
            
            if errorExist {
                self.navigationController?.pushViewController(notFoundViewController, animated: true)
            } else {
                DispatchQueue.main.async {
                    self.restaurantTable.reloadData()
                    self.loader.stopAnimating()
                }
            }
        })
    }
    
    private func setupTableView() {
        restaurantTable.separatorStyle = .none
        restaurantTable.delegate = self
        restaurantTable.dataSource = self
        restaurantTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        restaurantTable.register(customCellView,
                               forCellReuseIdentifier: cellIdentifier)
    }
    
    private func setupDescriptionText() {
        TextUtils.highlightTexts(in: descriptionText, config: [
            (descriptionToHighlightA, .blue, .bold(size: highlightTextSize)),
            (descriptionToHighlightB, .blue, .bold(size: highlightTextSize))
        ])
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bussines.restaurantCarrier.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CustomTableViewCell {
            cell.configCell(
                distance: bussines.restaurantCarrier[indexPath.row].distance,
                restaurantName: bussines.restaurantCarrier[indexPath.row].name,
                isAvailable: bussines.restaurantCarrier[indexPath.row].isAvailable
            )
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !bussines.restaurantCarrier[indexPath.row].isAvailable {
            bussines.selectedRestaurantID = bussines.restaurantCarrier[indexPath.row].id
            
            guard let selectedID = bussines.selectedRestaurantID else {
                print(Lang.Error.commonError)
                return
            }
            
            let service = RestaurantService()
            let bussines = DetailBussines(restaurantId: selectedID, restaurantService: service)
            let viewController = RestaurantDetailViewController(bussines: bussines)
            
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
