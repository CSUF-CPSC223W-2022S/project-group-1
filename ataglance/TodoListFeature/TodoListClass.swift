//
//  TodoListClass.swift
//  ataglance
//
//  Created by Luis Alvarado on 4/8/22.
//

import Foundation
import UIKit

class ToDoList:UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var todoArray = ["Finish Project", "Work on main Screen"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Today's Todo List 📝"
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    //@breif: notifies the user that the segue is about to be used.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSeg" {
            //as! allows the subclass
            //@breif: tells the destination
            let dest = segue.destination as! TodoDetailTableViewController
            //@Breif: Index path that idemtifies the row and section of the selected row.
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            dest.tasks = todoArray[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    @IBAction func unwindDetail(segue: UIStoryboardSegue) {
        let source = segue.source as! TodoDetailTableViewController
        //checks if row exists
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            todoArray[selectedIndexPath.row] = source.tasks
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: todoArray.count, section: 0)
            todoArray.append(source.tasks)
            tableView.insertRows(at:[newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
    }
}

extension ToDoList: UITableViewDelegate, UITableViewDataSource {
    
    // Supplies data to the tableview. Includes both count and cell index selection

    // @Breif: Displays the amount of tasks inside the todo list
    // @param: Int
    // @returns: the total amount of tasks in the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }

    //  @Breif: Creates an Id for a cell.
    //  @param: String to register
    //  @return: asserts the text into the cell in the nth term.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // supply datacell data
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // item in the ith position.
        cell.textLabel?.text = todoArray[indexPath.row]
        return cell
    }
}
