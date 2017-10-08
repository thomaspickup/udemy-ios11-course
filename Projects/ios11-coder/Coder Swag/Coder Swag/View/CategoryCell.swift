//
//  CategoryCell.swift
//  Coder Swag
//
//  Created by Thomas Pickup on 29/08/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    
    func updateViews(category: Category) {
        imgCategory.image = UIImage(named: category.imageName)
        lblCategory.text = category.title
    }

}
