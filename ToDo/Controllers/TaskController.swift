//
//  TaskController.swift
//  ToDo
//
//  Created by Cameron Collins on 5/21/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import Foundation

protocol TaskControllerDelegate {
    func updateViews()
}


class TaskController {
    
    //MARK: - Properties
    var sections: [Section] = []
    var delegate: TaskControllerDelegate?
    
    //MARK: - Methods
    
    ///Fetches and Saves Tasks to Tasks Variable in the TaskController
    func fetchTasks() {
        let allTasks = CoreDataStack.shared.fetchAllTasks()
        organizeTasks(tasks: allTasks)
    }
    
    ///Create a new Task, save it and place it in the correct section. Calls protocol updateViews function!
    func createTask(title: String, bodyText: String, complete: Bool, section: String = "Default") {
        
        //Unwrapping Delegate
        guard let delegate = delegate as? TaskTableViewController else {
            print("Bad delegate in TaskController!")
            return
        }
        
        //Creating Task and Saving to CoreDataStack
        Task(title: title, bodyText: bodyText, complete: complete, section: section)
        
        //Save Task If we have the CoreDataStack Object
        delegate.coreDataStack.save()
        
        //Update Delegate Views
        delegate.updateViews()
    }
    
    ///Create a new Section. The new section is appended to the sections array. Calls protocol updateViews function!
    func createASection(name: String) {
        
        //Checking if we already have the section name
        let result = findSection(name: name)
    
        //Create a section since we don't have this name yet
        if result == false {
            sections.append(Section(name: name, tasks: []))
        }
        
        //Update Views
        delegate?.updateViews()
    }
    
    ///Organizes all Tasks into the correct sections
    func organizeTasks(tasks: [Task]) {
        
        //Loop Through Tasks and Organize them
        for i in sections {
            for l in tasks {
                
                //Section name is equal to tasks section name
                if i.name == l.section {
                    i.tasks.append(l) //Add to section
                    break
                }
            }
        }
    }
    
    ///Finds a Section and returns true if it finds one.
    func findSection(name: String) -> Bool {
        
        for i in sections {
            if i.name == name {
                return true
            }
        }
        
        return false
    }
    
}
