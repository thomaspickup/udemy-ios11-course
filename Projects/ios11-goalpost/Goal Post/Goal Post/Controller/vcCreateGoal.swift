//
//  vcCreateGoal.swift
//  Goal Post
//
//  Created by Thomas Pickup on 12/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcCreateGoal: UIViewController, UITextViewDelegate {
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
        textView.delegate = self
    }
    
    // Actions
    @IBAction func onNextButtonPressed(_ sender: Any) {
        if textView.text != "" && textView.text != "What is your goal?" {
            guard let finishGoal = storyboard?.instantiateViewController(withIdentifier: "vcAddGoal") as? vcAddGoal else {return}
            finishGoal.initData(description: textView.text!, type: goalType)
            presentDetails(finishGoal)
        }
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
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
