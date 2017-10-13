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
        // Pass data to core data
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
        
    }
}
