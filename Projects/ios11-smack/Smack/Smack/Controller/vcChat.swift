//
//  vcChat.swift
//  Smack
//
//  Created by Thomas Pickup on 02/09/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcChat: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Outlets
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var tblMessages: UITableView!
    @IBOutlet weak var lblTyping: UILabel!
    
    // Variables
    var isTyping = false
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        
        btnMenu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControlEvents.touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(vcChat.handleTap))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(vcChat.userDataDidChange(_:)), name: NOTIF_USER_DATA_CHANGED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(vcChat.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        tblMessages.delegate = self
        tblMessages.dataSource = self
        tblMessages.estimatedRowHeight = 80
        tblMessages.rowHeight = UITableViewAutomaticDimension
        
        SocketService.instance.getMessages { (newMessage) in
            if newMessage.channelID == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.messages.append(newMessage)
                
                self.tblMessages.reloadData()
                
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    
                    self.tblMessages.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
        
        SocketService.instance.getTyping { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser, channel) in typingUsers {
                if typingUser != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                        numberOfTypers += 1
                    } else {
                        names = "\(names), \(typingUser)"
                        numberOfTypers += 1
                    }
                }
            }
            
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true {
                var verb = "is"
                
                if numberOfTypers > 1 {
                    verb = "are"
                }
                
                self.lblTyping.text = "\(names) \(verb) typing..."
            } else {
                self.lblTyping.text = ""
            }
        }
        
        btnSend.isHidden = true

        if AuthService.instance.isLoggedIn {
        AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
            })
        }
    }
    
    // Actions
    @IBAction func onSendPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let message = txtMessage.text else { return }
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success {
                    self.txtMessage.text = ""
                    self.txtMessage.resignFirstResponder()
                    SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
                }
            })
        }
    }
    
    @IBAction func onEditingChanged(_ sender: Any) {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        if txtMessage.text == "" {
            isTyping = false
            btnSend.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
        } else {
            if isTyping == false {
                btnSend.isHidden = false
            }
            SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId)
            isTyping = true
        }
    }
    
    // Functions
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            lblTitle.text = "Please Log In"
            tblMessages.reloadData()
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.title ?? ""
        lblTitle.text = "#\(channelName)"
        getMessages()
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.lblTitle.text = "No channels yet!"
                }
            }
        }
    }
    
    func getMessages() {
        guard let channelID = MessageService.instance.selectedChannel?.id else { return }
        
        MessageService.instance.findAllMessages(channelId: channelID) { (success) in
            if success {
                self.tblMessages.reloadData()
            }
        }
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    // Protocols
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tblMessages.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
