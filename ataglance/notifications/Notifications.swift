//
//  Notifications.swift
//  ataglance
//
//  Created by Brian Escobar on 3/23/22.
//

import Foundation

// .year, .month, .day, .hour, .minute


class Notification: Equatable {
    
    var title: String
    var message: String
    var year: Int
    var month: Int
    var day: Int
    var hour: Int
    var minute: Int
    
    init(title: String, message: String,year: Int,month: Int,day: Int,hour: Int,minute: Int) {
        self.title  = title
        self.message = message
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
    }
    
    func getTitle() -> String {
        return title
    }
    func getMessage() -> String {
        return message
    }
    func getYear() -> Int {
        return year
    }
    func getMonth() -> Int {
        return month
    }
    func getDay() -> Int{
        return day
    }
    func getHour() -> Int {
        return hour
    }
    func getMinute() -> Int {
        return minute
    }
    
    func changeNotificationMessage(newMessage: String) {
        message = newMessage
    }

    func changeNotificationDate(newYear: Int, newMonth: Int, newDay: Int, newHour: Int, newMinute: Int) {
       year = newYear
       month = newMonth
       day = newDay
        hour = newHour
        minute = newMinute
        
    }

    func changeNotificationTitle(newTitle: String ) {
                title = newTitle
            }
    
    static func == (lhs: Notification, rhs: Notification ) -> Bool {
            return
                lhs.title == rhs.title &&
                lhs.message == rhs.message &&
                lhs.year == rhs.year &&
        lhs.month == rhs.month &&
        lhs.day == rhs.day &&
        lhs.hour == rhs.hour &&
        lhs.minute == rhs.minute
        
        }
    
}

class NotificationList{
    var notifications: [Notification] = []
    var notificationCount: Int
    
    init() {
        notifications = []
        notificationCount = 0
    }
    
    
    


    func addNotification(newNotification: Notification) {
        notifications.append(newNotification)
        notificationCount += 1
    }

    func deleteNotification(Notification: Notification) {
        let index = notifications.firstIndex(of: Notification)
        if let indexvalue = index  {
            notifications.remove(at: indexvalue)
            notificationCount -= 1
        } else {
            print("Notification does not exist")
        }
    }
    
//    func findNotification(Notification: Notification) {
//    let index = notifications.firstIndex(of: Notification)
//    if let indexvalue = index  {
//
//    } else {
//        print("Notification does not exist")
//        return
//    }
//    }
}
    
