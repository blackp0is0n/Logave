//
//  MessagingController.swift
//  Logave
//
//  Created by Andrew Johnsson on 15.09.15.
//  Copyright © 2015 Alex. All rights reserved.
//

import UIKit

class ConversationCell:UITableViewCell{
    @IBOutlet weak var recepientPicture: UIImageView!
    @IBOutlet weak var lastMessagePicture: UIImageView!
    @IBOutlet weak var recepientLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var lastMessageTime: UILabel!
}

class MessagingController:UITableViewController{

    struct Conversation {
        let recipient: String
        let recepientAvatar: UIImage!
        let userAvatar: UIImage!
        let lastMessage: String
        let lastMessageTime: NSDate
    }
    
    var conversations = [Conversation]()
    var filteredConversations = [Conversation]()
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        
        let conversationCell = tableView.dequeueReusableCellWithIdentifier("conversationCell") as! ConversationCell
        
        let conversation = self.conversations[indexPath.row]
        
        conversationCell.recepientLabel.text = conversation.recipient
        conversationCell.recepientPicture.image = conversation.recepientAvatar
        conversationCell.lastMessagePicture.image = conversation.userAvatar
        conversationCell.lastMessageLabel.text = conversation.lastMessage
        conversationCell.lastMessageTime.text = dateFormatter.stringFromDate(conversation.lastMessageTime)
        return conversationCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conversations.append(Conversation(recipient: "Tim Cock", recepientAvatar: UIImage(named: "menu"), userAvatar: UIImage(named: "menu"), lastMessage: "Logave is magic",lastMessageTime: NSDate()))
        
        self.conversations = [
            Conversation(recipient: "Tim Cock", recepientAvatar: UIImage(named: "menu"), userAvatar: UIImage(named: "menu"), lastMessage: "Logave is magic",lastMessageTime: NSDate()),
            Conversation(recipient: "Alex Cfuck0ff", recepientAvatar: UIImage(named: "menu"), userAvatar: UIImage(named: "menu"), lastMessage: "But right now...",lastMessageTime: NSDate()),
            Conversation(recipient: "John Appleseed", recepientAvatar: UIImage(named: "menu"), userAvatar: UIImage(named: "menu"), lastMessage: "It hurts you much at",lastMessageTime: NSDate()),
            Conversation(recipient: "ZOG", recepientAvatar: UIImage(named: "menu"), userAvatar: UIImage(named: "menu"), lastMessage: "BUTT!",lastMessageTime: NSDate())
        ]

        self.tableView.reloadData()
        
    }
}
