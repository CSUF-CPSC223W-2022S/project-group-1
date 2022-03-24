//
//  Notifications.swift
//  ataglance
//
//  Created by Brian Escobar on 3/23/22.
//

import Foundation

class Notifications {
    var notifMessages: [String] = []
    var notifTime: [String] = []
    var notifNumber: Int
    var test: Int
    
    init() {
        notifNumber = 0
        notifMessages = []
        notifTime = []
    }

    func addNotification(time: String, message: String) {
        notifMessages.append(message)
        notifTime.append(time)
        notifNumber += 1
    }

    func deleteNotification(time: String, message: String) {
        let indexVal = getMessageIndex(messageTarget: message)
        if indexVal != -1 {
            notifMessages.remove(at: indexVal)
            notifNumber -= 1
        } else {
            print("Notification does not exist")
        }
    }

    func changeNotificationMessage(time: String, newMessage: String) {
        let index = getTimeIndex(TimeTarget: time)
        notifMessages[index] = newMessage
    }

    func changeNotificationTime(newTime: String, message: String) {
        let index = getMessageIndex(messageTarget: message)
        notifTime[index] = newTime
    }

    func displayNotification(time: String) {
        let index = getTimeIndex(TimeTarget: time)
        print(" \(notifMessages[index])")
    }

    func getMessageIndex(messageTarget: String) -> Int {
        for (index, messages) in notifMessages.enumerated() {
            if messages == messageTarget {
                return index
            }
        }
        return -1
    }

    func getTimeIndex(TimeTarget: String) -> Int {
        for (index, time) in notifTime.enumerated() {
            if time == TimeTarget {
                return index
            }
        }
        return -1
    }
}
