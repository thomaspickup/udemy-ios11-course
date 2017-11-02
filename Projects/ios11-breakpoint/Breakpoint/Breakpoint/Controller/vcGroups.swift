//
//  SecondViewController.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 15/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcGroups: UIViewController {
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var groups = [Group]()
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllGroups { (groupArray) in
                self.groups = groupArray
                self.tableView.reloadData()
            }
        }
    }
    
    // Functions
    
}

extension vcGroups: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell else { return UITableViewCell() }
        
        cell.configureCell(title: groups[indexPath.row].title, description: groups[indexPath.row].description, memberCount: groups[indexPath.row].count)
        
        return cell
    }
}
