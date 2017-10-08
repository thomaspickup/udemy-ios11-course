//
//  ProductCell.swift
//  Coder Swag
//
//  Created by Thomas Pickup on 02/09/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    
    func updateView(product: Product) {
        imgProduct.image = UIImage(named: product.imageName)
        txtTitle.text = product.title
        txtPrice.text = product.price
    }
}
