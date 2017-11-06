//
//  vcGroupFeed.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 03/11/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit
import Firebase

class vcGroupFeed: UIViewController {
    // Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblMembers: UILabel!
    @IBOutlet weak var txtMessage: InSetTextField!
    @IBOutlet weak var messageView: UIView!
    
    // Variables
    var group: Group?
    var messages = [Message]()
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        messageView.bindToKeyboard()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lblTitle.text = group?.title
        DataService.instance.getEmail(forGroup: group!) { (emailsReturned) in
            self.lblMembers.text = emailsReturned.joined(separator: ", ")
        }
        
        DataService.instance.REF_GROUPS.observe(.value) { (snap) in
            DataService.instance.getAllGroupMessages(forDesiredGroup: self.group!, handler: { (returnedMessages) in
                self.messages = returnedMessages
                self.tableView.reloadData()
                
                if self.messages.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath.init(row: self.messages.count - 1, section: 0), at: .none, animated: true)
                }
            })
        }
    }
    // Actions
    @IBAction func onBackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onSendPressed(_ sender: Any) {
        if txtMessage.text != "" {
            let message = txtMessage.text
            
            DataService.instance.uploadPost(withMessage: message!, forUID: Auth.auth().currentUser!.uid, withGroupKey: group?.key, sendComplete: { (complete) in
                self.txtMessage.text = ""
            })
        }
    }
    
    // Functions
    func initData(forGroup group: Group) {
        self.group = group
    }
}

extension vcGroupFeed: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupFeedCell", for: indexPath) as? GroupFeedCell else { return UITableViewCell() }
        let message = messages[indexPath.row]
        
        DataService.instance.getUsername(forUID: message.senderID) { (email) in
            cell.configureCell(profileImage: #imageLiteral(resourceName: "defaultProfileImage"), email: email, content: message.content)
        }
        
        return cell
    }
}
