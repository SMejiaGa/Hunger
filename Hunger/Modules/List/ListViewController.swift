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
    private let bussines = ListBussines()
    private var detailViewController = RestaurantDetailViewController()
    private let cellIdentifier = "CustomTableViewCell"
    private let cellReuseIdentifier = "myCell"
    private let descriptionToHighlightA = "buena comida"
    private let descriptionToHighlightB = "precio justo"
    private let showMapSegue = "showMapSegue"
    private let detailCheckSegue = "detailCheckSegue"
    private let highlightTextSize: CGFloat = 19
    private var slideMenuActive = false
    private var restaurantIDToFind: Int?
    private let showMapSegue = "showMapSegue"
    private let aboutUsSegue = "showAboutUsSegue"
    private let notFoundSegue = "ShowNotFound"
    
    // MARK: - IBOutlets
    @IBOutlet weak var messagesTable: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var descriptionText: UILabel!
    
    @IBOutlet private weak var viewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var viewLeadingConstraint: NSLayoutConstraint!
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
    @IBAction func showAlertButton() {
        let alert = UIAlertController(title: "Elige una opcion", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Mostrar mapa", style: .default, handler: { _ in
            self.performSegue(withIdentifier: "showMapSegue", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: {_ in
            }))
        self.present(alert, animated: true, completion: {
        })
    }
    
    @IBAction private func showAlertButton() {
        let alert = UIAlertController(title: Lang.List.chooseAnOptionMessage, message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: Lang.List.showMapLabelMessage, style: .default, handler: { _ in
            self.performSegue(withIdentifier: self.showMapSegue, sender: nil)
        }))
        alert.addAction(UIAlertAction(title: Lang.List.aboutUsMessage, style: .default, handler: { _ in
            self.performSegue(withIdentifier: self.aboutUsSegue, sender: nil)
        }))
        alert.addAction(UIAlertAction(title: Lang.List.cancelMessage, style: .cancel, handler: {_ in
            }))
        self.present(alert, animated: true, completion: {
        })
    }
    
    // MARK: - Private methods
    private func fetchData() {
        bussines.fetchRestaurants(onFinished: { errorExist in
            if errorExist {
                self.performSegue(withIdentifier: self.notFoundSegue, sender: nil)
            } else {
                DispatchQueue.main.async {
                    self.messagesTable.reloadData()
                    self.loader.stopAnimating()
                }
            }
        })
    }
    
    private func setupTableView() {
        messagesTable.separatorStyle = .none
        messagesTable.delegate = self
        messagesTable.dataSource = self
        messagesTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        messagesTable.register(customCellView,
                               forCellReuseIdentifier: cellIdentifier)
    }
    
    private func setupDescriptionText() {
        TextUtils.highlightTexts(in: descriptionText, config: [
            (descriptionToHighlightA, .blue, .bold(size: highlightTextSize)),
            (descriptionToHighlightB, .blue, .bold(size: highlightTextSize))
        ])
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.destination is RestaurantDetailViewController {
             let viewControllerVar = segue.destination as? RestaurantDetailViewController
             guard let selectedID = bussines.selectedRestaurantID else {
                 print(Lang.Error.commonError)
                 return
             }
             viewControllerVar?.bussines = DetailBussines(restaurantId: selectedID)
         }
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
            performSegue(withIdentifier: detailCheckSegue, sender: nil)
        }
    }
    
}
