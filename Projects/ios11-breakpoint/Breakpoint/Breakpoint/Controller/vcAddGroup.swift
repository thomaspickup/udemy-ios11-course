//
//  vcAddGroup.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 31/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcAddGroup: UIViewController {
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtEmail: InSetTextField!
    @IBOutlet weak var txtDescription: InSetTextField!
    @IBOutlet weak var txtTitle: InSetTextField!
    // Variables
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Actions
    @IBAction func onExitPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onDonePressed(_ sender: Any) {
        
    }
    
    // Functions
    
}
