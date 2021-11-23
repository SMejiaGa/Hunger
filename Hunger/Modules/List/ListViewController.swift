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
    private var bussines = ListBussines()
    private let cellIdentifier = "CustomTableViewCell"
    private let cellReuseIdentifier = "myCell"
    private let descriptionToHighlightA = "buena comida"
    private let descriptionToHighlightB = "precio justo"
    private let highlightTextSize: CGFloat = 19
    private var slideMenuActive = false
    
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
    
    @IBAction func backButton() {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func slideButton() {
        if !slideMenuActive {
        
            viewLeadingConstraint.constant = -150
            viewTrailingConstraint.constant = -150
            
            slideMenuActive = true
        } else {
          
            viewLeadingConstraint.constant = 0
            viewTrailingConstraint.constant = 0
            
            slideMenuActive = false
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn) {
            self.view.layoutIfNeeded()
        } 

    }
    
    // MARK: - Private methods
    private func fetchData() {
        bussines.fetchRestaurants(onFinished: { errorExist in
            if errorExist {
                self.performSegue(withIdentifier: "ShowNotFound", sender: nil)
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
    
}
