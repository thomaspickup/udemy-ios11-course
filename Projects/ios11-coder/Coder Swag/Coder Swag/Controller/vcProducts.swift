//
//  vcProducts.swift
//  Coder Swag
//
//  Created by Thomas Pickup on 02/09/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcProducts: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var productsCollection: UICollectionView!
    private(set) public var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productsCollection.dataSource = self
        productsCollection.delegate = self
    }
    
    func initProducts(category: Category) {
        products = DataService.instance.getProducts(forCategoryTitle: category.title)
        navigationItem.title = category.title
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell {
            let product = products[indexPath.row]
            cell.updateView(product: product)
            return cell
        } else {
            return ProductCell()
        }
    }
}
