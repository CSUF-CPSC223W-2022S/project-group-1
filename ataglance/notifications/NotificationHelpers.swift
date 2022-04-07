//
//  NotificationHelpers.swift
//  ataglance
//
//  Created by Brian Escobar on 3/24/22.
//

import Foundation




class notificationMessages {
    var notifMessages: [String] = []
    var MessageCount: Int
    

    init() {
        notifMessages = []
        MessageCount = 0
    }
    
    
    

    func addMessage(message: String) {
        notifMessages.append(message)
    }

    func deleteMessage(message: String) {
        if let index = notifMessages.firstIndex(of: message) {
            notifMessages.remove(at: index)
        } else {
            print(" This message does not exist")
        }
    }

    func changeMessage(newMessage: String, oldMessage: String) {
        if let index = notifMessages.firstIndex(of: oldMessage) {
            notifMessages[index] = newMessage
        } else {
            print("This message does not exist")
        }
    }

    func displayMessage() {
        
    }
}

class notificationTime {
    var notifTime: [String] = []
    var TimesCount: Int

    init() {
        notifTime = []
        TimesCount = 0
    }

    func addTime(time: String) {
        notifTime.append(time)
    }

    func deleteTime(time: String) {
        if let index = notifTime.firstIndex(of: time) {
            notifTime.remove(at: index)
        } else {
            print("This time does not exist")
        }
    }

    func changeTime() {
        
        
        
    }

    func displayTime() {
        
        
    }
}
