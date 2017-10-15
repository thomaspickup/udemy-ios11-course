//
//  vcGoals.swift
//  Goal Post
//
//  Created by Thomas Pickup on 08/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit
import CoreData

let appdelegate = UIApplication.shared.delegate as? AppDelegate

class vcGoals: UIViewController {
    // Outlets
    @IBOutlet weak var TableView: UITableView!
    
    // Variables
    
    var goals: [Goal] = []
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Temp Need To Change <
        TableView.isHidden = false;
        // >
        
        TableView.delegate = self;
        TableView.dataSource = self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetch { (complete) in
            if goals.count >= 1 {
                TableView.isHidden = false
            } else {
                TableView.isHidden = true
            }
        }
        
        TableView.reloadData()
    }
    
    // Actions
    @IBAction func onGoalButtonPressed(_ sender: Any) {
        guard let vcCreateGoal = storyboard?.instantiateViewController(withIdentifier: "vcCreateGoal") else { return }
        
        presentDetails(vcCreateGoal)
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
        return goals.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = TableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
        
        let goal = goals[indexPath.row]
            
        cell.configureCell(goal: goal)
        
        return cell
    }
}

extension vcGoals {
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appdelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint("Failed to fetch")
            completion(false)
        }
    }
}







