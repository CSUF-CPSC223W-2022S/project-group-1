//
//  EventEdit.swift
//  ataglance
//
//  Created by abraham medina on 5/4/22.
//

import UIKit

class EventEditViewController: UIViewController
{
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        datePicker.date = selectedDate
    }
     
    @IBAction func saveAction(_ sender: Any)
    {
        let newEvent = Event()
        newEvent.id = eventsList.count
        newEvent.name = nameTF.text
        newEvent.date = datePicker.date
        
        eventsList.append(newEvent)
        navigationController?.popViewController(animated: true)
    }
}

