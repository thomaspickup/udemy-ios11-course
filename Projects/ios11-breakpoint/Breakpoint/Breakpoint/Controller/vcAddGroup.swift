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
    
    @IBOutlet weak var btnDone: UIButton!
    // Variables
    var emails = [String]()
    var chosenUserArray = [String]()
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        txtEmail.delegate = self
        txtEmail.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        btnDone.isHidden = true
    }
    
    // Actions
    @IBAction func onExitPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDonePressed(_ sender: Any) {

    }
    
    // Functions
    @objc func textFieldDidChanged() {
        if txtEmail.text == "" {
            emails = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: txtEmail.text!, handler: { (emailArray) in
                self.emails = emailArray
                self.tableView.reloadData()
            })
        }
    }
}

extension vcAddGroup: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else { return UITableViewCell() }
        
        if chosenUserArray.contains(emails[indexPath.row]) {
            cell.configureCell(profileImage: #imageLiteral(resourceName: "defaultProfileImage"), email: emails[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImage: #imageLiteral(resourceName: "defaultProfileImage"), email: emails[indexPath.row], isSelected: false)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        
        if !chosenUserArray.contains(cell.lblUser.text!) {
            chosenUserArray.append(cell.lblUser.text!)
            btnDone.isHidden = false
        } else {
            chosenUserArray = chosenUserArray.filter({ $0 != cell.lblUser.text! })
            if chosenUserArray.count == 0 {
                btnDone.isHidden = true
            }
        }
    }
}

extension vcAddGroup: UITextFieldDelegate {
    
}
