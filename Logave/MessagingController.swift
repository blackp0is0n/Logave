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
    
    let conversations = ["John Appleseed","Alexander Sifakoff","Big Boss","ZOG"]
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let conversation = tableView.dequeueReusableCellWithIdentifier("conversationCell") as! ConversationCell

        conversation.recepientLabel.text = conversations[indexPath.row]
        conversation.lastMessageLabel.text = "Last Conversation's Message"
        
        return conversation
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: (NSIndexPath!)) {
        self.performSegueWithIdentifier("showConversation", sender: self)
    }
}
