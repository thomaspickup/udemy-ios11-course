//
//  vcGoals.swift
//  Goal Post
//
//  Created by Thomas Pickup on 08/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcGoals: UIViewController {
    // Outlets
    @IBOutlet weak var TableView: UITableView!
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.isHidden = true;
    }

    // Actions
    @IBAction func onGoalButtonPressed(_ sender: Any) {
        
    }
    
    // Functions

}

