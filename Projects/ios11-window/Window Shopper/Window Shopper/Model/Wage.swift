//
//  Wage.swift
//  Window Shopper
//
//  Created by Thomas Pickup on 28/08/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import Foundation
class Wage {
    class func getHours(forWage wage: Double, andPrice price: Double) -> Int{
        return Int(ceil(price / wage))
    }
}
