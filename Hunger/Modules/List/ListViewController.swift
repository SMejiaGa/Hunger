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
    
    // MARK: - IBOutlets
    @IBOutlet weak var messagesTable: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var descriptionText: UILabel!
    
    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupTableView()
        //setupDescriptionText()
    }
    
    // MARK: - IBActions
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private methods
    private func fetchData() {
        bussines.fetchMessages(onFinished: {
            DispatchQueue.main.async {
                self.messagesTable.reloadData()
                self.loader.stopAnimating()
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
        TextUtils.highlightTextInLabel(
            textToSetup: descriptionText,
            textToHighlight: descriptionToHighlightA,
            color: .blue,
            font: .bold(size: CGFloat(19))
        )
        TextUtils.highlightTextInLabel(
            textToSetup: descriptionText,
            textToHighlight: descriptionToHighlightB,
            color: .blue,
            font: .bold(size: CGFloat(19))
        )
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bussines.messageCarrier.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CustomTableViewCell {
            cell.configCell(user: bussines.messageCarrier[indexPath.row].user,message: bussines.messageCarrier[indexPath.row].message)
            return cell
        }
        return UITableViewCell()
    }
}
