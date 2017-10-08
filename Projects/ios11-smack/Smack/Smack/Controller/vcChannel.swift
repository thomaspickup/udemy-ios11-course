//
//  vcChannel.swift
//  Smack
//
//  Created by Thomas Pickup on 02/09/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcChannel: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Outlets
    @IBOutlet weak var tblChannels: UITableView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var imgUser: RoundedImage!
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblChannels.delegate = self
        tblChannels.dataSource = self
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(vcChannel.userDataDidChange(_:)), name: NOTIF_USER_DATA_CHANGED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(vcChannel.channelsDataDidChange(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        
        SocketService.instance.getChannel { (success) in
            if success {
                self.tblChannels.reloadData()
            }
        }
        
        SocketService.instance.getMessages { (newMessage) in
            if newMessage.channelID != MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.unreadChannels.append(newMessage.channelID)
                self.tblChannels.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpUserInfo()
    }
    
    // Actions
    @IBAction func btnLoginPreseed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let profile = vcProfile()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    @IBAction func onAddChannelPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let addChannel = vcAddChannel()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
            
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
            
        }
    }
    
    @IBAction func preparForUnwind(segue: UIStoryboardSegue) {}
    
    // Functions
    @objc func userDataDidChange(_ notif: Notification) {
       setUpUserInfo()
    }
    
    @objc func channelsDataDidChange(_ notif: Notification) {
        tblChannels.reloadData()
    }
    
    func setUpUserInfo() {
        if AuthService.instance.isLoggedIn {
            btnLogin.setTitle(UserDataService.instance.name, for: .normal)
            imgUser.image = UIImage(named: UserDataService.instance.avatarName)
            imgUser.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            btnLogin.setTitle("Login", for: .normal)
            imgUser.image = UIImage(named: "menuProfileIcon")
            imgUser.backgroundColor = UIColor.clear
            tblChannels.reloadData()
        }
    }
    
    // Table View Protocol
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        
        if MessageService.instance.unreadChannels.count > 0 {
            MessageService.instance.unreadChannels = MessageService.instance.unreadChannels.filter{$0 != channel.id}
        }
        
        let index = IndexPath(row: indexPath.row, section: 0)
        
        tblChannels.reloadRows(at: [index], with: .none)
        tblChannels.selectRow(at: index, animated: false, scrollPosition: .none)
        
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        self.revealViewController().revealToggle(animated: true)
    }
}
