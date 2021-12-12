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
    private let presenter: ListPresenter
    private let cellIdentifier = "CustomTableViewCell"
    private let cellReuseIdentifier = "myCell"
    private let descriptionToHighlightA = "buena comida"
    private let descriptionToHighlightB = "precio justo"
    private let highlightTextSize: CGFloat = 19
    private var slideMenuActive = false
    private var restaurantIDToFind: Int?
    
    // MARK: - IBOutlets
    @IBOutlet private weak var restaurantTable: UITableView!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    @IBOutlet private weak var descriptionText: UILabel!
    
    // MARK: - Init required for xib initialization
    
    init(presenter: ListPresenter) {
        self.presenter = presenter
    
        super.init(nibName: String(describing: Self.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        presenter.fetchRestaurants()
        setupTableView()
        setupDescriptionText()
    }
    
    // MARK: - IBActions
    
    @IBAction private func backButton() {
        navigationController?.popViewController(animated: true)
    }
   
    @IBAction private func showAlertButton() {

        let alert = UIAlertController(title: Lang.List.chooseAnOptionMessage, message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: Lang.List.showMapLabelMessage, style: .default, handler: { [weak self] _ in
            
            let mapPresenter = MapPresenter(service: MapService())
            let mapViewController = MapViewController(presenter: mapPresenter)
            
            guard let self = self else { return }
            self.navigationController?.pushViewController(mapViewController, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: Lang.List.aboutUsMessage, style: .default, handler: { [weak self] _ in
            
            let aboutUsPresenter = AboutUsPresenter(service: AboutUsService())
            let aboutUsViewController = AboutUsViewController(presenter: aboutUsPresenter)
            
            guard let self = self else { return }
            self.navigationController?.pushViewController(aboutUsViewController, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: Lang.List.logoutMessage, style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: Lang.List.cancelMessage, style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: {
        })
    }
    
    // MARK: - Private methods 
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

// MARK: - ListPresenterDelegate
extension ListViewController: ListPresenterDelegate {
    func toggleLoader(isLoading: Bool) {
        isLoading ? loader.startAnimating() : loader.stopAnimating()
    }
    
    func showError() {
        let notFoundViewController = NotFoundViewController()
        navigationController?.pushViewController(
            notFoundViewController,
            animated: true
        )
    }
    
    func setRestaurantList() {
        DispatchQueue.main.async {
            self.restaurantTable.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.restaurantCarrier.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CustomTableViewCell {
            cell.configCell(
                distance: presenter.restaurantCarrier[indexPath.row].distance,
                restaurantName: presenter.restaurantCarrier[indexPath.row].name,
                isAvailable: presenter.restaurantCarrier[indexPath.row].isAvailable
            )
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !presenter.restaurantCarrier[indexPath.row].isAvailable {
            presenter.selectedRestaurantID = presenter.restaurantCarrier[indexPath.row].id
            
            guard let selectedID = presenter.selectedRestaurantID else {
                print(Lang.Error.commonError)
                return
            }
            
            let service = RestaurantService()
            let presenter = DetailPresenter(restaurantId: selectedID, service: service)
            let viewController = RestaurantDetailViewController(presenter: presenter)
            
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
