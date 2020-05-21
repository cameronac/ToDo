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
        
        //Fetch all Tasks
        tasks = coreDataStack.fetchAllTasks()
        
        //Get Saved Settings
        navigationController?.navigationBar.barTintColor = colorController.getSavedColor()
    }
    
    //MARK: - Functions
    func updateTableView() {
        tasks = coreDataStack.fetchAllTasks()
        tableView.reloadData()
    }
    
    //MARK: - Properties
    let coreDataStack = CoreDataStack()
    var tasks: [Task]?
    let colorController = ColorController()

    // MARK: - Table view data source
    
    //Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //Number of Tasks
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }

    //Setting Cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath)

        //Unwrapping
        guard let tasks = tasks else {
            print("Tasks is nil in: \(#file) \(#function) \(#line)")
            return cell
        }
        
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
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
            
        default:
            break
        }
    }
}
