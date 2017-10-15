//
//  GoalCell.swift
//  Goal Post
//
//  Created by Thomas Pickup on 09/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    // Outlets
    @IBOutlet weak var lblGoalDesc: UILabel!
    @IBOutlet weak var lblGoalType: UILabel!
    @IBOutlet weak var lblGoalProgress: UILabel!
    @IBOutlet weak var completionView: UIView!
    
    // Variables
    
    // View Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Actions
    
    // Functions
    func configureCell(goal: Goal) {
        self.lblGoalDesc.text = goal.goalDescription
        self.lblGoalType.text = goal.goalType
        self.lblGoalProgress.text = String(describing: goal.goalProgressValue)
        
        if goal.goalProgressValue == goal.goalCompletionValue {
            self.completionView.isHidden = false
        } else {
            self.completionView.isHidden = true
        }
    }
}
