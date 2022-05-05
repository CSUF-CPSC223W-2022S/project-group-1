//
//  NotificationsViewController.swift
//  ataglance
//
//  Created by Brian Escobar on 3/23/22.
//

import UIKit
import UserNotifications

class NotificationsViewController: UIViewController
{
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var messageTF: UITextField!
    @IBOutlet var titleTF: UITextField!
    
    var notificationList = NotificationList()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        notificationCenter.requestAuthorization(options: [.alert, .sound])
        {
            permissionGranted, _ in
            if !permissionGranted
            {
                print("Permission Denied")
            }
        }
    }

    @IBAction func scheduleAction(_ sender: Any)
    {
        notificationCenter.getNotificationSettings
        { settings in
            DispatchQueue.main.async
            {
                let title = self.titleTF.text!
                let message = self.messageTF.text!
                let date = self.datePicker.date
                
                if settings.authorizationStatus == .authorized
                {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = message
                    
                    let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                    
                    let newNotification = Notification(title: title, message: message, year: dateComp.year!, month: dateComp.month!, day: dateComp.day!, hour: dateComp.hour!, minute: dateComp.minute!)
                    
                    self.notificationList.addNotification(newNotification: newNotification)
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    self.notificationCenter.add(request)
                    { error in
                        if error != nil
                        {
                            print("Error " + error.debugDescription)
                            return
                        }
                    }
                    let ac = UIAlertController(title: "Notification Scheduled", message: "At " + self.formattedDate(date: date), preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
                    self.present(ac, animated: true)
                }
                else
                {
                    let ac = UIAlertController(title: "Enable Notifications?", message: "To use this feature you must enable notifications in settings", preferredStyle: .alert)
                    let goToSettings = UIAlertAction(title: "Settings", style: .default)
                    { _ in
                        guard let setttingsURL = URL(string: UIApplication.openSettingsURLString)
                        else
                        {
                            return
                        }
                        
                        if UIApplication.shared.canOpenURL(setttingsURL)
                        {
                            UIApplication.shared.open(setttingsURL) { _ in }
                        }
                    }
                    ac.addAction(goToSettings)
                    ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in }))
                    self.present(ac, animated: true)
                }
            }
        }
    }
    
    func formattedDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y HH:mm"
        return formatter.string(from: date)
    }
}
