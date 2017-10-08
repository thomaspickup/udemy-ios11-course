//
//  vcCategory.swift
//  Coder Swag
//
//  Created by Thomas Pickup on 29/08/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcCategory: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tblCategory: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblCategory.dataSource = self
        tblCategory.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getCategories().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell {
            let category = DataService.instance.getCategories()[indexPath.row]
            
            cell.updateViews(category: category)
            
            return cell
        } else {
            return CategoryCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = DataService.instance.getCategories()[indexPath.row]
        
        performSegue(withIdentifier: "toProducts", sender: category)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productsVC = segue.destination as? vcProducts {
            let btnBack = UIBarButtonItem()
            btnBack.title = ""
            navigationItem.backBarButtonItem = btnBack
            assert(sender as? Category != nil)
            productsVC.initProducts(category: sender as! Category)
            
        }
    }
}

