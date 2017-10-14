//
//  vcAddGoal.swift
//  Goal Post
//
//  Created by Thomas Pickup on 13/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcAddGoal: UIViewController, UITextFieldDelegate {
    // Outlets
    @IBOutlet weak var txtProgress: UITextField!
    @IBOutlet weak var btnCreateGoal: UIButton!
    
    // Variables
    var goalDescription: String!
    var goalType: GoalType!
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        btnCreateGoal.bindToKeyboard()
        txtProgress.delegate = self
    }
    
    // Actions
    @IBAction func onCreateGoalPressed(_ sender: Any) {
        if txtProgress != nil {
            self.save { (success) in
                if success {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        dismissDetails()
    }
    
    // Functions
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    func save(completion: (_ finsihed: Bool) -> ()) {
        guard let managedContext = appdelegate?.persistentContainer.viewContext else { return }
        
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(txtProgress.text!)!
        goal.goalProgressValue = Int32(0)
        
        do {
            try managedContext.save()
            debugPrint("Saved Data")
            completion(true)
        } catch {
            debugPrint("Could not save")
            completion(false)
        }
    }
}








