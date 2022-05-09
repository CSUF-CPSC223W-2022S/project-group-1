//
//  HomeViewController.swift
//  ataglance
//
//  Created by Brian Escobar on 5/4/22.
//

import UIKit

class HomeViewController: UIViewController {
    var notificationList = NotificationList()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let VC = segue.destination as? TableViewController {
            VC.notificationList = notificationList
           
        } else if let VC = segue.destination as? NotificationsViewController {
            VC.notificationList = notificationList
        }
    }
}
