//
//  vcPop.swift
//  Pixel City
//
//  Created by Thomas Pickup on 19/09/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit
import Alamofire

class vcPop: UIViewController {
    // Outlets
    @IBOutlet weak var imgPop: UIImageView!
    @IBOutlet var popView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    
    // Variables
    var passedImage: UIImage!
    var passedData: FlickrImage!
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwipe()
        
        imgPop.image = passedImage
        lblTitle.text = "Title: \(passedData.title!)"
        retriveUser(userID: passedData.user!)
    }
    
    // Actions
    @IBAction func onClosePressed(_ sender: Any) {
        closeView()
    }
    
    // Functions
    func initData(data: FlickrImage, forImage image: UIImage) {
        self.passedImage = image
        self.passedData = data
    }
    
    func addSwipe() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(closeView))
        swipe.direction = .down
        
        popView.addGestureRecognizer(swipe)
    }
    
    @objc func closeView() {
        dismiss(animated: true, completion: nil)
    }
    
    func retriveUser(userID: String) {
        Alamofire.request(FLICKR_USER_URL(userID: userID)).responseJSON { (jresult) in
            guard let userjson = jresult.result.value as? Dictionary<String, AnyObject> else { return }
            let usersDict = userjson["person"] as! Dictionary<String, AnyObject>
            let users = usersDict["username"] as! Dictionary<String, AnyObject>
            
            var username = (users["_content"] as? String)!
            
            self.lblUsername.text = "Taken By: \(username)"
        }
    }
}
