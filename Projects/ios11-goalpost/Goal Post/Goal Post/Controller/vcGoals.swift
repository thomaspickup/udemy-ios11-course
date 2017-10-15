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
    @IBOutlet weak var UndoViewHeight: NSLayoutConstraint!
    
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
        
        fetchCoreData()
        
        TableView.reloadData()
    }
    
    // Actions
    @IBAction func onGoalButtonPressed(_ sender: Any) {
        guard let vcCreateGoal = storyboard?.instantiateViewController(withIdentifier: "vcCreateGoal") else { return }
        
        presentDetails(vcCreateGoal)
    }
    
    // Functions
    func fetchCoreData() {
        self.fetch { (complete) in
            if goals.count >= 1 {
                TableView.isHidden = false
            } else {
                TableView.isHidden = true
            }
        }
    }
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        let addAction = UITableViewRowAction(style: .normal, title: "Add") { (rowAction, indexPath) in
            self.set(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        addAction.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.662745098, blue: 0.2666666667, alpha: 1)
        
        return [deleteAction, addAction]
    }
}

extension vcGoals {
    func set(atIndexPath indexPath: IndexPath) {
        guard let managedConext = appdelegate?.persistentContainer.viewContext else { return }
        
        let chooseGoal = goals[indexPath.row]
        
        if chooseGoal.goalProgressValue < chooseGoal.goalCompletionValue {
            chooseGoal.goalProgressValue = chooseGoal.goalProgressValue + 1
        } else {
            return
        }
        
        do {
            try managedConext.save()
            debugPrint("Set progress")
        } catch {
            debugPrint("Could not Save \(error.localizedDescription)")
        }
    }
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
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedConext = appdelegate?.persistentContainer.viewContext else { return }
        
        managedConext.delete(goals[indexPath.row])
        
        do {
            try managedConext.save()
            debugPrint("Removed Goal")
        } catch {
            debugPrint("Could not save changes")
        }
    }
}







