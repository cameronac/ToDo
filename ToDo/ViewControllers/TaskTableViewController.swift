//
//  TaskTableViewController.swift
//  ToDo
//
//  Created by Cameron Collins on 5/12/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {

    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting Delegates
        taskController.delegate = self
        
        taskController.fetchTasks()
        
        //Get Saved Settings
        navigationController?.navigationBar.barTintColor = colorController.getSavedColor()
    }

    
    //MARK: - Properties
    let coreDataStack = CoreDataStack()
    var tasks: [Task]?
    let taskController = TaskController()
    let colorController = ColorController()

    // MARK: - Table view data source
    
    //# of Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return taskController.sections.count
    }

    //# of Tasks for each Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskController.sections[section].tasks.count
    }

    //Setting up Cells giving them the necessary properties to display correctly
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath)
        
        //Getting Tasks
        let tasks = taskController.sections[indexPath.section].tasks
        
        //Downcasting
        guard let tempCell = cell as? TaskTableViewCell else {
            print("Couldn't downcast cell to TaskTableViewCell in: \(#file) \(#function) \(#line)")
            return cell
        }
        
        //Assign Task variable in cell
        tempCell.task = tasks[indexPath.row]
        tempCell.coreDataStack = coreDataStack
        
        return tempCell
    }
    
    //Section Title's
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return taskController.sections[section].name
    }
    
    
    // MARK: - Navigation
    
    //Prepare Segue assigning delegates and variables to viewControllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Unwrap
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case TaskDetailViewController.identifier:
            guard let destination = segue.destination as? TaskDetailViewController else {
                break
            }
            
            //Unwrapping Task
            guard let tasks = tasks, let row = tableView.indexPathForSelectedRow?.row else {
                print("Tasks is nil when preparing for segue or bad row selection!")
                return
            }
            
            destination.task = tasks[row]
            destination.coreDataStack = coreDataStack
            break
            
        case CreateTaskViewController.identifier:
            guard let destination = segue.destination as? CreateTaskViewController else {
                break
            }
            
            destination.delegate = self
            destination.coreDataStack = coreDataStack
            break
            
        case ThemePickerViewController.identifier:
            guard let destination = segue.destination as? ThemePickerViewController else {
                break
            }
            destination.delegate = self
            destination.colorController = colorController
            break
            
        case CreateSectionViewController.identifier:
            guard let destination = segue.destination as? CreateSectionViewController else {
                break
            }
            destination.delegate = self
            break
            
        default:
            break
        }
    }
}


extension TaskTableViewController: TaskControllerDelegate {
    func updateViews() {
        tableView.reloadData()
    }
}
