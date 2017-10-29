//
//  FirstViewController.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 15/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcFeed: UIViewController {
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var messageArray = [Message]()
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getAllFeedMessages { (returned) in
            self.messageArray = returned.reversed()
            self.tableView.reloadData()
        }
    }
    // Actions
    
    // Functions
    
}

extension vcFeed: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedCell else { return UITableViewCell() }
        
        let image = #imageLiteral(resourceName: "defaultProfileImage")
        let message = messageArray[indexPath.row]
        
        cell.configureCell(profileImage: image, email: message.senderID, content: message.content)
        
        return cell
    }
}
