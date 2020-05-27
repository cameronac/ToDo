//
//  TaskController.swift
//  ToDo
//
//  Created by Cameron Collins on 5/21/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

protocol TaskControllerDelegate {
    func updateViews()
}

class TaskController {
    
    //MARK: - Properties
    public var sections: [Section] = []
    public var delegate: TaskControllerDelegate?
    
    
    //MARK: - Methods
    
    //MARK: - Public
    
    ///Fetches and Saves Tasks to Tasks Variable in the TaskController
    public func fetchTasks() {
        let allTasks = CoreDataStack.shared.fetchAllTasks()
        organizeTasks(tasks: allTasks)
    }
    
    ///Create a new Task, save it and place it in the correct section. Calls protocol updateViews function!
    public func createTask(title: String, bodyText: String, complete: Bool, section: String = "Default") {
        
        //Unwrapping Delegate
        guard let delegate = delegate as? TaskTableViewController else {
            print("Bad delegate in TaskController!")
            return
        }
        
        //Creating Task and Saving to CoreDataStack
        let task = Task(title: title, bodyText: bodyText, complete: complete, section: section)
        
        //Organize Single Task in Sections
        organizeSingleTask(task: task)
        
        //Save Task If we have the CoreDataStack Object
        delegate.coreDataStack.save()
        
        //Update Delegate Views
        delegate.updateViews()
    }
    
    ///Create a new Section. The new section is appended to the sections array. Calls protocol updateViews function!
    public func createASection(name: String) {
        
        //Checking if we already have the section name
        let result = findSection(name: name)
    
        //Create a section since we don't have this name yet
        if result == false {
            guard let delegate = delegate as? TaskTableViewController else {
                print("Bad delegate in TaskController: Create Section Functions")
                return
            }
            
            //Adding Section
            sections.append(Section(name: name, tasks: [], taskTableView: delegate.self, sectionIndex: sections.count))
        }
        
        //Update Views
        delegate?.updateViews()
    }
    
    ///Deletes a whole section and saves the changes
    public func deleteASection(index: Int) {
        
        //Unwrapping Delegate
        guard let delegate = delegate as? TaskTableViewController else {
            print("Couldn't downcast delegate as TaskTableViewController!")
            return
        }
        
        //Loop through Tasks and delete them
        for i in sections[index].tasks {
            
            guard let task = i else {
                print("Task is nil in \(#file) \(#function) \(#line)")
                continue
            }
            delegate.coreDataStack.delete(object: task)
        }
        
        delegate.coreDataStack.save() //Save Deleted Tasks
        
        //Delete Section
        sections.remove(at: index)
        resetSectionTags()
        delegate.updateViews()
    }
    
    ///Finds a Section and returns the Section
    public func getSection(name: String) -> Int? {
        
        for i in 0...sections.count - 1 {
            if sections[i].name == name {
                return i
            }
        }
        
        return nil
    }

    ///Collapse Section: Modifies isCollapsed variable in Section and Returns the Index of the Section to be collapsed
    public func collapse(section name: String) -> Int? {
        var section: Int?
        
        //Get the correct section
        for i in 0...sections.count - 1 {
            if sections[i].name == name {
                sections[i].isCollapsed = !sections[i].isCollapsed
                section = i
                break
            }
        }
        
        return section
    }
    
    
    //MARK: - Private Functions
    
    ///Rest Section Tags Prevents Index from getting out of range with the section button tags
    private func resetSectionTags() {

        if sections.count > 0 {
            //Giving Sections their tags
            for i in 0...sections.count - 1 {
                sections[i].sectionIndex = i
            }
        }
    }
    
    ///Organizes all Tasks into the correct sections. Meant to be only used once when starting up the app.
    private func organizeTasks(tasks: [Task]) {
        
        //Loop Through and Add the necessary Sections
        for i in tasks {
            //Unwrapping Section name
            guard let sectionName = i.section else {
                print("Caution Task Went Through organizeTasks without a section!")
                continue
            }
    
            createASection(name: sectionName)
        }
        
        
        //Loop Through Tasks and Organize them
        for i in sections {
            for l in tasks {
                //Section name is equal to tasks section name
                if i.name == l.section {
                    i.tasks.append(l) //Add to Tasks to Section
                }
            }
        }
    }
    
    ///Organizes a Single Task into the correct Section
    private func organizeSingleTask(task: Task) {
        
        //Unwrapping Section name
        guard let sectionName = task.section else {
            print("Caution Task Went Through organizeTasks without a section!")
            return
        }
        
        createASection(name: sectionName)
        
        for i in sections {
            if i.name == task.section {
                i.tasks.append(task)
                break
            }
        }
    }
    
    ///Finds a Section and returns true if it finds one.
    private func findSection(name: String) -> Bool {
        
        for i in sections {
            if i.name == name {
                return true
            }
        }
        
        return false
    }
    
}
