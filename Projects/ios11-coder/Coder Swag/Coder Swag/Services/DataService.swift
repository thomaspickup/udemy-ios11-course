//
//  DataService.swift
//  Coder Swag
//
//  Created by Thomas Pickup on 02/09/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import Foundation

class DataService {
    static let instance = DataService()
    
    private let categories = [
        Category(title: "SHIRTS", imageName: "shirts.png"),
        Category(title: "HOODIES", imageName: "hoodies.png"),
        Category(title: "HATS", imageName: "hats.png"),
        Category(title: "DIGITAL", imageName: "digital.png")]
    
    private let hats = [
        Product(title: "Devslopes Logo Graphic Beanie", price: "£18", imageName: "hat01.png"),
        Product(title: "Devslopes Logo Hat Black", price: "£32", imageName: "hat02.png"),
        Product(title: "Devslopes Logo Hat White", price: "£22", imageName: "hat03.png"),
        Product(title: "Devslopes Logo Snapback", price: "£28", imageName: "hat03.png")
    ]
    
    private let hoodies = [
        Product(title: "Devslopes Logo Hoodie Gray", price: "£32", imageName: "hoodie01.png"),
        Product(title: "Devslopes Logo Hoodie Red", price: "£32", imageName: "hoodie02.png"),
        Product(title: "Devslopes Hoodie Gray", price: "£32", imageName: "hoodie03.png"),
        Product(title: "Devslopes Hoodie Black", price: "£32", imageName: "hoodie04.png")
    ]
    
    private let shirts = [
        Product(title: "Devslopes Logo Shirt Black", price: "£18", imageName: "shirt01.png"),
        Product(title: "Devslopes Badge Shirt Light Gray", price: "£19", imageName: "shirt02.png"),
        Product(title: "Devslopes Logo Shirt Red", price: "£18", imageName: "shirt03.png"),
        Product(title: "Hustle Delegate Gray", price: "£18", imageName: "shirt04.png"),
        Product(title: "Kickflip Studios Black", price: "£18", imageName: "shirt05.png")
    ]
    
    private let digital = [Product]()
    
    func getProducts(forCategoryTitle title:String) -> [Product] {
        switch title {
        case "SHIRTS":
            return getShirts()
        case "HATS":
            return getHats()
        case "HOODIES":
            return getHoodies()
        case "DIGITAL":
            return getDigital()
        default:
            return getShirts()
        }
    }
    
    func getHats() -> [Product] {
        return hats
    }
    
    func getHoodies() -> [Product] {
        return hoodies
    }
    
    func getShirts() -> [Product] {
        return shirts
    }
    
    func getDigital() -> [Product] {
        return digital
    }
    
    func getCategories() -> [Category]{
        return categories
    }
}
