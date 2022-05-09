//
//  TableViewController.swift
//  ataglance
//
//  Created by Brian Escobar on 5/3/22.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var NotificationsTableView: UITableView!
    
    var notificationList = NotificationList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.notificationCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellID") as! TableViewCell
        let thisNotification = notificationList.notifications[indexPath.row]
        
        tableViewCell.NotificationTitle.text = thisNotification.title
        tableViewCell.NotificationTime.text = thisNotification.getNotificationDate()
        return tableViewCell
    }
}
