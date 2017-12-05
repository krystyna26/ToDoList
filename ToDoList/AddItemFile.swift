//
//  AddItemViewController.swift
//  ToDoList
//
//  Created by Krystyna Swider on 11/8/17.
//  Copyright © 2017 Krystyna Swider. All rights reserved.
//

import UIKit

class AddItemFile: UIViewController {
    
    var delegate: AddItemDelegate?
    
    @IBOutlet weak var taskTextFiled: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func addItemButtonPressed(_ sender: UIButton) {
        print("addItemButtonPressed in AddItemFile")
        let title = taskTextFiled.text
        let description = descriptionTextField.text
        let date = datePicker.date
        delegate?.addItemButtonPressed(self, title: title!, description: description!, date: date)
    }
    
    
//    weak var delegate: AddItemDelegate?
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
}
