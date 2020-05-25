//
//  TaskTableViewController.swift
//  ToDo
//
//  Created by Cameron Collins on 5/12/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit
import CoreGraphics

class TaskTableViewController: UITableViewController {

    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting Delegates
        taskController.delegate = self
        taskController.fetchTasks()
        
        //Get Saved Settings
        navigationController?.navigationBar.barTintColor = colorController.getSavedColor()
        tableView.reloadData()
    }

    //MARK: - Properties
    let coreDataStack = CoreDataStack()
    var tasks: [Task]?
    let taskController = TaskController()
    let colorController = ColorController()
    static let headerHeight: CGFloat = 40

    
    // MARK: - Table view data source
    
    //Deleting Rows
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        //Deleting Row
        if editingStyle == .delete {
            
            guard let task = taskController.sections[indexPath.section].tasks[indexPath.row] else {
                print("Couldn't delete task in: \(#file) \(#function) \(#line)")
                return
            }
            
            //Delete From CoreData First
            coreDataStack.delete(object: task)
            
            //Delete From Fetched Tasks
            taskController.sections[indexPath.section].tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            //Inserting
            
            
            
        }
    }
    
    //# of Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return taskController.sections.count
    }

    //# of Tasks for each Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //isCollapsed == false
        if taskController.sections[section].isCollapsed == false {
            return 0
        } else {
            return taskController.sections[section].tasks.count + 1
        }
    }
    
    //Setting up Cells giving them the necessary properties to display correctly
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Task Cell
        if indexPath.row < taskController.sections[indexPath.section].tasks.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as! TaskTableViewCell
            
            //Assign Task variable in cell
            cell.task = taskController.sections[indexPath.section].tasks[indexPath.row]
            cell.coreDataStack = coreDataStack
            
            return cell
        } else {
            
            //Add Task Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskAddTableViewCell.identifier, for: indexPath) as! TaskAddTableViewCell
            
            return cell
        }
    }
    
    //Section Title's
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return taskController.sections[section].name
    }

    //Setting Selected Section so CreateTaskViewController| Tells Task what Section to add tasks to
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Table View height
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
            
            //Unwrapping
            guard let indexPath = tableView.indexPathForSelectedRow else {
                print("IndexPath is nil when unwrapping it in the tableView")
                return
            }
            
            print("Section: \(indexPath.section), Row: \(indexPath.row)")
            
            destination.delegate = self
            destination.task = taskController.sections[indexPath.section].tasks[indexPath.row]
            destination.coreDataStack = coreDataStack
            break
            
        case CreateTaskViewController.identifier:
            guard let destination = segue.destination as? CreateTaskViewController else {
                break
            }
            
            destination.delegate = self
            destination.indexPath = tableView.indexPathForSelectedRow
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
    
    ///Reloads TableView
    func updateViews() {
        tableView.reloadData()
    }
    
    //Setting Up Header

    //Step: 1
    //Setting Headers Height since we already know it's width
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //Step: 2
    //Giving Header view it's section view from taskController.sections.view
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return taskController.sections[section].view
    }
    
    ///Section Button was Pressed
    @objc func sectionButtonPressed(sender: UIButton) {
        
        //Unwrapping Section Title
        guard let text = sender.titleLabel?.text else {
            print("Section Button does not have a name!")
            return
        }
        
        //Collapse Section
        let _ = taskController.collapse(section: text)
        
        updateViews()
    }
    
    
    
}
