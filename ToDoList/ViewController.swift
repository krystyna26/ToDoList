//  ViewController.swift
//  ToDoList
//
//  Created by Krystyna Swider on 11/8/17.
//  Copyright © 2017 Krystyna Swider. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController, AddItemDelegate{
//    called fetchTask() in viewDidLoad
//    fetchED Task
//    fetchTask() done
//    prepare for segue
//    @ addItemButtonPressed in AddItemFile
//    addItemButtonPressed so let's create a new task in addItemButtonPressed() in VC
    
    func addItemButtonPressed(_ sender: AddItemFile, title: String, description: String, date: Date) {
        // 2 - Create new task
        print("addItemButtonPressed so let's create a new task in addItemButtonPressed in VC")
        let createTask = NSEntityDescription.insertNewObject(forEntityName: "Task", into:  manageObjectContext) as! Task
        createTask.title = title
        createTask.date = date
        createTask.desc = description
        createTask.completed = false
        tasks.append(createTask)
        // 3 - Commit changes using the managedObjectContext:
        do {
            try manageObjectContext.save()
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
        sender.dismiss(animated: true)
    }
    
    // 1 - This will enable you to communicate with Core Data
//    print("comunicate with CoreData")
    let manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 6 - Fetch all items on page load, and save into data source:
        print("called fetchTask() in viewDidLoad")
        fetchTasks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


//extension ViewController: UITableViewDataSource {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomCell
        // 7 - Set text of cell with item text
        let taskToDo = tasks[indexPath.row]
        //title
        cell.titleLabel.text = taskToDo.title
        // description
        cell.descriptionLabel.text = taskToDo.desc
        // date
        let dateForm = DateFormatter()
        dateForm.dateFormat = "MM/dd/yyyy"
        let dateAsString = dateForm.string(from: taskToDo.date!)
        cell.dateLabel.text = dateAsString
        return cell
    }

    // delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let taskToDelete = tasks[indexPath.row]
        manageObjectContext.delete(taskToDelete)
        do{
            try manageObjectContext.save()
        } catch {
            print("\(error)")
        }
        tasks.remove(at: indexPath.row)
        tableView.reloadData()
    }

    // prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! AddItemFile
        print("prepare for segue")
        // Set Self as Destination Delegate
        dest.delegate = self
    }
    

    func fetchTasks() {
        // 4 - Tell Core Data that we want to fetch items
     
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do {
            // Iterate through records:
            // get the results by executing the fetch request we made earlier
            let result = try manageObjectContext.fetch(request)
            // downcast the results as an array of AwesomeEntity objects
            tasks = result as! [Task]
            print("fetched Task")
        } catch {
            // print the error if it is caught (Swift automatically saves the error in "error")
            print("\(error)")
        }
        print("fetchTask() done")
    }
    

    // checkmark
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskToDo = tasks[indexPath.row]
        taskToDo.completed = !taskToDo.completed
        do {
            try manageObjectContext.save()
        } catch {
            print("error")
        }
        let cell = tableView.cellForRow(at: indexPath)
        if taskToDo.completed {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
    }
}
