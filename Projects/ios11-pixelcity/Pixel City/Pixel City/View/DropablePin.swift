//
//  DropablePin.swift
//  Pixel City
//
//  Created by Thomas Pickup on 17/09/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit
import MapKit

class DropbalePin: NSObject, MKAnnotation {
    // Variables
    var coordinate: CLLocationCoordinate2D
    var identifier: String
    
    // Initializer
    init(coordinate: CLLocationCoordinate2D, identifier: String) {
        self.coordinate = coordinate
        self.identifier = identifier
        
        super.init()
    }
}
