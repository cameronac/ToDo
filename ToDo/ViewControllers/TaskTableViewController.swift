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
        tasks = coreDataStack.fetchAllTasks()
    }
    
    //MARK: - Functions
    func updateTableView() {
        tasks = coreDataStack.fetchAllTasks()
        tableView.reloadData()
    }
    
    //MARK: - Properties
    let coreDataStack = CoreDataStack()
    var tasks: [Task]?

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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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
            
            destination.coreDataStack = coreDataStack
            break
            
        case CreateTaskViewController.identifier:
            guard let destination = segue.destination as? CreateTaskViewController else {
                break
            }
            
            destination.delegate = self
            destination.coreDataStack = coreDataStack
            break
            
        default:
            break
        }
    }
}
