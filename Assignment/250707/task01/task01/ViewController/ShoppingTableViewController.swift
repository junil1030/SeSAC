//
//  CustomTableViewController.swift
//  task01
//
//  Created by 서준일 on 7/10/25.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var shoppingManager = ShoppingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.layer.cornerRadius = 15
        inputTextField.borderStyle = .none
        addButton.layer.cornerRadius = 15
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerFooterView = UITableViewHeaderFooterView()
        
        var configuration = headerFooterView.defaultContentConfiguration()
        
        configuration.textProperties.color = .red
        
        if section == 0 {
            configuration.text = "구매 전 목록"
        } else {
            configuration.text = "구매 후 목록"
        }
        
        headerFooterView.contentConfiguration = configuration
        
        return headerFooterView
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return shoppingManager.items.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shoppingManager.items[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyShoppingCell", for: indexPath) as! ShoppingTableViewCell
        
        let item =  shoppingManager.items[indexPath.section][indexPath.row]
        
        cell.productLabel.text = item.name
        let favoriteImage = item.isFavorite ? "star.fill" : "star"
        cell.favoriteButton.setImage(UIImage(systemName: favoriteImage), for: .normal)
        let checkImage = item.isPurchased ? "checkmark.square.fill" : "checkmark.square"
        cell.checkButton.setImage(UIImage(systemName: checkImage), for: .normal)
        
        cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
        cell.checkButton.addTarget(self, action: #selector(purchaseButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] _, _, _ in
            guard let self = self else { return }
            
            shoppingManager.removeItem(at: indexPath)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        if let text = inputTextField.text, !text.isEmpty {
            shoppingManager.addItem(name: text)
            tableView.reloadData()
        }
    }
    
    @objc func favoriteButtonClicked(_ sender: UIButton) {
        guard let indexPath = indexPathForButton(sender) else { return }
        
        shoppingManager.updateFavorite(at: indexPath)
        tableView.reloadData()
    }
    
    @objc func purchaseButtonClicked(_ sender: UIButton) {
        guard let indexPath = indexPathForButton(sender) else { return }
        
        shoppingManager.updatePurchase(at: indexPath)
        tableView.reloadData()
    }
    
    private func indexPathForButton(_ button: UIButton) -> IndexPath? {
        var view = button.superview
        while let currentView = view {
            if let cell = currentView as? ShoppingTableViewCell {
                return tableView.indexPath(for: cell)
            }
            view = currentView.superview
        }
        return nil
    }
}
