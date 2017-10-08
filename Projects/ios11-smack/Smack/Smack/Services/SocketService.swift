//
//  SocketService.swift
//  Smack
//
//  Created by Thomas Pickup on 03/09/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    // Variables
    static let instance = SocketService()
    var socket : SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)

    // Initilizers
    override init() {
        super.init()
    }
    
    // Functions
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(name: String, description: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", name, description)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelID = dataArray[2] as? String else { return }
            
            let newChannel = Channel(title: channelName, description: channelDescription, id: channelID)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        
        completion(true)
    }
    
    func getMessages(completion: @escaping (_ newMessage: Message) -> Void) {
        socket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColour = dataArray[5] as? String else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let timeStamp = dataArray[7] as? String else { return }
            
            let newMessage = Message(id: id, message: msgBody, userName: userName, channelID: channelId, userAvatar: userAvatar, userAvatarColour: userAvatarColour, timestamp: timeStamp)
        
            completion(newMessage)
        }
    }
    
    func getTyping(_ completionHandler: @escaping (_ typingUsers: [String: String]) -> Void) {
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String: String] else { return }
            
            completionHandler(typingUsers)
        }
    }
}















