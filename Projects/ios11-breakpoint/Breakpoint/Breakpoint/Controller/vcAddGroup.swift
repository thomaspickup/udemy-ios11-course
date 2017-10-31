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
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Actions
    @IBAction func onExitPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onDonePressed(_ sender: Any) {
        
    }
    
    // Functions
    
}

extension vcAddGroup: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else { return UITableViewCell() }
        
        cell.configureCell(profileImage: #imageLiteral(resourceName: "defaultProfileImage"), email: "Test@test.com", isSelected: false)
        
        return cell
    }
}
