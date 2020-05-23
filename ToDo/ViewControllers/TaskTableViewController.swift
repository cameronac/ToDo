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
        
        //isCollapsed == false
        if taskController.sections[section].isCollapsed == false {
            return 0
        } else {
            return taskController.sections[section].tasks.count
        }
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

    //Display View on Section Header
    /*override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView(section: section)
    }*/
    
    //Setting Header Colors and Title
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        //Down Casting
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        
        view.tintColor = .gray
        //header.textLabel?.textColor = UIColor.white
        modifyHeaderView(header: header, section: section)
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
    
    ///Reloads TableView
    func updateViews() {
        tableView.reloadData()
    }
    
    ///Creating HeaderView and Adding it a target
    func modifyHeaderView(header: UITableViewHeaderFooterView, section: Int) {
        taskController.sections[section].headerView.header = header
        let button = taskController.sections[section].headerView.button
        button.addTarget(self, action: #selector(sectionButtonPressed(sender:)), for: .touchUpInside)
    }
    
    ///Section Button was Pressed
    @objc func sectionButtonPressed(sender: UIButton) {
        
        //Unwrapping Section Title
        guard let text = sender.titleLabel?.text else {
            print("Section Button does not have a name!")
            return
        }
        
        //Collapse Section
        taskController.collapse(section: text)
        
        //Find Index
        guard let index = taskController.getSection(name: text) else {
            print("Returned Bad Index using taskController")
            return
        }
        
        print(index)
        
        //Set Label
        if taskController.sections[index].isCollapsed == true {
            taskController.sections[index].headerView.label.text = "↓"
        } else {
            taskController.sections[index].headerView.label.text = "→"
        }
        
        updateViews()
    }
    
    
    
}
