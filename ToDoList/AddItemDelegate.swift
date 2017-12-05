//
//  AddItem.swift
//  ToDoList
//
//  Created by Krystyna Swider on 11/8/17.
//  Copyright © 2017 Krystyna Swider. All rights reserved.
//

import Foundation
protocol AddItemDelegate: class {
    func addItemButtonPressed(_ sender:AddItemFile, title: String,  description: String, date: Date)
}
