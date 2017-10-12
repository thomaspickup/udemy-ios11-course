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
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Actions
    @IBAction func onNextButtonPressed(_ sender: Any) {
    }

    @IBAction func onShortTermButtonPressed(_ sender: Any) {
    }
    
    @IBAction func onLongTermButtonPressed(_ sender: Any) {
    }
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Functions
    
}
