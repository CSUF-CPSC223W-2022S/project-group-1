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
    var tasks: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        if tasks == nil {
            tasks = ""
        }
        
        textField.text = tasks
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        tasks = textField.text
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
