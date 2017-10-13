//
//  vcCreateGoal.swift
//  Goal Post
//
//  Created by Thomas Pickup on 12/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcCreateGoal: UIViewController {
    // Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btnShortTerm: UIButton!
    @IBOutlet weak var btnLongTerm: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    // Variables
    var goalType: GoalType = .shortTerm
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.bindToKeyboard()
        btnShortTerm.setSelectedColour()
        btnLongTerm.setDeselectedColour()
    }
    
    // Actions
    @IBAction func onNextButtonPressed(_ sender: Any) {
    }

    @IBAction func onShortTermButtonPressed(_ sender: Any) {
        self.btnShortTerm.setSelectedColour()
        goalType = .shortTerm
        self.btnLongTerm.setDeselectedColour()
    }
    
    @IBAction func onLongTermButtonPressed(_ sender: Any) {
        self.btnLongTerm.setSelectedColour()
        goalType = .longTerm
        self.btnShortTerm.setDeselectedColour()
    }
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        dismissDetails()
    }
    
    // Functions
    
}
