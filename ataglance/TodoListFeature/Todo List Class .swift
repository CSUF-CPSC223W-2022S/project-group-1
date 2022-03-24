//
//  Todo Classes.swift
//  ataglance
//
//  Created by Luis Alvarado on 3/8/22.
//

import Foundation
import UIKit

//Things To add on todo list class
//1. Array to keep all the tasks to do in todo list.
//2. A way to mark as task completed.
//3. A way to delete a task.
//4. A way to display the tasks in the array.
//5. A way to replace existing task to something else.
//6. A way to display how many tasks the user has in the todo list.
//7. Maintain a way to keep the tasks when app is closed.

//Checkpoint 3: Add the swift UIKIT and organize the way I want my UI storyboard to look like

class Todolist: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!

    //@breif: Tableview that displays the cells of rows in the feature
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    // @Brief: Contains an empty array to hold the tasks the user inputs.
    var tasks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tasks = UserDefaults.standard.stringArray(forKey:"tasks") ?? []

        // displays the title of the todo list storyboard
        title = "Todo List 📝"
        view.addSubview(table)

        // table views property. Self = data will be provided
        table.dataSource = self
        // adds button to the right hand side of the UI
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    

    // @Breif: Displays the add button on the right side of the screen
    @objc private func didTapAdd() {
        let popup = UIAlertController(title: "Add", message: "Please enter new task: ", preferredStyle: .alert)

        // @Brief: Adds a task field onto the popup
        popup.addTextField { field in
            field.placeholder = "Enter a task...."
        }

        // @Brief: Displays "Cancel" button on popup
        popup.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        // @Breif: Displays "Save" button on popup. Gets the input of the
        popup.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            if let field = popup.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    // new todo task onto the cell
                    DispatchQueue.main.async {
                        //Saves all the tasks in the list in the tableview.
                        var assertcurrentItems = UserDefaults.standard.stringArray(forKey:"tasks") ?? []
                        assertcurrentItems.append(text)
                        UserDefaults.standard.setValue(assertcurrentItems, forKey: "tasks")
                        self?.tasks.append(text)
                        self?.table.reloadData()
                    }
                }
            }
        }))
        present(popup, animated: true)
    }
    
    //@breif: Displays the text on the cell
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    //Supplies data to the tableview. Includes both count and cell index selection

    // @Breif: Displays the amount of tasks inside the todo list
    // @param: Int
    // @returns: the total amount of tasks in the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    //  @Breif: Creates an Id for a cell.
    //  @param: String to register
    //  @return: asserts the text into the cell in the nth term.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // supply datacell data
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // item in the ith position.
        cell.textLabel?.text = tasks[indexPath.row]

        return cell
    }
    
    

}
