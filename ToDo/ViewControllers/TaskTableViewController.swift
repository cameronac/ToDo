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
        tableView.rowHeight = 60
        
        //Get Saved Settings
        navigationController?.navigationBar.barTintColor = colorController.getSavedColor()
        updateViews()
        updateSectionColors()
    }

    //MARK: - Properties
    public let coreDataStack = CoreDataStack()
    public let taskController = TaskController()
    public let colorController = ColorController()
    static let headerHeight: CGFloat = 60
   
    ///0 - Theme, 1 - Header
    public var colorFor = 0
    
    ///If brush was pressed on a section header then this will show the index of the header that was pressed
    public var sectionIndex: Int? = nil
    

    //MARK: - Actions
    @IBAction func colorButtonPressed(_ sender: UIBarButtonItem) {
        colorFor = 0
        self.performSegue(withIdentifier: ThemePickerViewController.identifier, sender: self)
    }
    
    
    //MARK: - Methods
    
    ///Updates Section Colors after fetching and creating tasks are done
    public func updateSectionColors() {
        let colorIndex = colorController.getSavedHeaderColors(taskTableView: self)
        var counter = 0

        //Double Check Index
        if taskController.sections.count > 0 {
            for i in colorIndex {
                taskController.sections[counter].colorIndex = i
                if let color = ColorController.colors[ColorController.colorNames[i]] {
                    taskController.sections[counter].viewColor = color
                }
                counter += 1
            }
        }
    }
    
    // MARK: - Table view data source
    
    //Prevent us from deleting ADD TASK row
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row >= taskController.sections[indexPath.section].tasks.count {
            return false
        } else {
            return true
        }
    }
    
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
        if taskController.sections[section].isCollapsed == true {
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
    
    //Setting Selected Section so CreateTaskViewController| Tells Task what Section to add tasks to
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Setting Table View height
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
        tableView.rowHeight = 60
    }
    
    //Setting Up Header

    //Step: 1
    //Setting Headers Height since we already know it's width
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TaskTableViewController.headerHeight
    }
    
    //Step: 2
    //Giving Header view it's section view from taskController.sections.view
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return taskController.sections[section].view
    }
    
    ///Section Collapse Button was pressed
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
    
    ///Section Color Button was pressed
    @objc func sectionColorButtonPressed(sender: UIButton) {
        colorFor = 1
        sectionIndex = sender.tag
        performSegue(withIdentifier: ThemePickerViewController.identifier, sender: self)
    }
    
    ///Section Delete Button was pressed
    @objc func sectionDeleteButtonPressed(sender: UIButton) {
        
        let alertController = UIAlertController(title: "Delete Section", message: "Are you sure!", preferredStyle: .alert)
        let alertAction1 = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            switch action.style {
            case .default:
                break
            case .cancel:
                break
            case .destructive:
                self.taskController.deleteASection(index: sender.tag)
            @unknown default:
                break
            }
        }
        let alertAction2 = UIAlertAction(title: "No", style: .default, handler: nil)
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}
