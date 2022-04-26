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
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
            addButton.isEnabled = true
        } else {
            tableView.setEditing(true, animated: true)
            sender.title = "Done"
            addButton.isEnabled = false
        }
    }
    
    var todoArray:[todoItems] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Today's Todo List 📝"
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
    }
    
    //@breif: function that loads data.
    func loadData() {
        //.first means gets the first element in the arrayu
        let URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        //append the file
        let documentURL = URL.appendingPathComponent("todos")
            .appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        
        do {
            todoArray = try jsonDecoder.decode(Array<todoItems>.self, from: data)
            tableView.reloadData()
        } catch {
            print("Could not load data.")
        }
    }
    
    //@breif: function that saves user data.
    func saveData() {
        //.first means gets the first element in the arrayu
        let URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        //append the file
        let documentURL = URL.appendingPathComponent("todos")
            .appendingPathExtension("json")
        let jsonEncoder = JSONEncoder()
        let data = try?jsonEncoder.encode(todoArray)
        
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {
            print("Could not save data.")
        }
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
        saveData()
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
        cell.textLabel?.text = todoArray[indexPath.row].name
        return cell
    }
    
    //@Breif: Removes data from task list.
    //@param: tableview
    //return: modified task list.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData()
        }
    }
    
    //@Breif: Allows the user to change the order of the tasks.
    //@param: Tableview
    //@return: the location placed.
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveobject = todoArray[sourceIndexPath.row]
        todoArray.remove(at: sourceIndexPath.row)
        todoArray.insert(moveobject, at: destinationIndexPath.row)
        saveData()
    }
}
