//
//  TodoDetailTableViewController.swift
//  ataglance
//
//  Created by Luis Alvarado on 4/9/22.
//

import UIKit

class TodoDetailTableViewController: UITableViewController {

    @IBOutlet weak var SaveButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var noteView: UITextView!
    
    //@Breif: Catches data from the todolistclass file(source).
    var tasks: todoItems!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        if tasks == nil {
            tasks = todoItems(name: "", date: Date(), notes: "")
        }
        
        textField.text = tasks.name
        datePicker.date = tasks.date
        noteView.text = tasks.notes
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        tasks = todoItems(name: textField.text!, date: datePicker.date, notes: noteView.text)
    }
    
    //@breif: allows the user to return back to the todolist menu when cancel is pressed.
    //@param: is pressing represents the viewcontroller
    //@return: user back to todolist page.
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        let presenting = presentingViewController is UINavigationController
        if presenting {
            dismiss(animated: true, completion:nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
