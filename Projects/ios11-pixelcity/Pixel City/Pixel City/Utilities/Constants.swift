//
//  Constants.swift
//  Pixel City
//
//  Created by Thomas Pickup on 19/09/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import Foundation

// Flickr API Constants
let FLICKR_API_KEY = "5935bed61ea06ccaf47679e11f10cb32"

func FLICKR_URL(forAPIKey key: String, withAnnotation annotation: DropbalePin, andNumberOfPhotos number: Int) -> String {
    return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(key)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=mi&per_page=\(number)&format=json&nojsoncallback=1"
}
func FLICKR_POST_URL(farm: AnyObject, server: AnyObject, id: AnyObject, secret: AnyObject) -> String {
    return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_h_d.jpg"
}

func FLICKR_USER_URL(userID id: String) -> String {
    return "https://api.flickr.com/services/rest/?method=flickr.people.getInfo&api_key=\(FLICKR_API_KEY)&user_id=\(id)&format=json&nojsoncallback=1"
}
// Completion Hamdler
typealias CompletionHandler = (_ status: Bool) -> ()
