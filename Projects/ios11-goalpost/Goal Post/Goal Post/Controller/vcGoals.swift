//
//  vcGoals.swift
//  Goal Post
//
//  Created by Thomas Pickup on 08/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit
import CoreData

class vcGoals: UIViewController {
    // Outlets
    @IBOutlet weak var TableView: UITableView!
    
    // Variables
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Temp Need To Change <
        TableView.isHidden = false;
        // >
        
        TableView.delegate = self;
        TableView.dataSource = self;
    }

    // Actions
    @IBAction func onGoalButtonPressed(_ sender: Any) {
        
    }
    
    // Functions

}

// Extensions
// Table View Extension
extension vcGoals: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = TableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
        cell.configureCell(description: "Eat Salad twice a week", type: .longTerm, progress: 2)
        return cell
    }
    
    
}
