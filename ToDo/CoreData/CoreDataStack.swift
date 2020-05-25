//
//  CoreDataStack.swift
//  ToDo
//
//  Created by Cameron Collins on 5/12/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import Foundation
import CoreData


class CoreDataStack {

    //MARK: - Properties
    //Singleton
    static let shared = CoreDataStack() //CoreDataStack Object
    
    //Create CoreDataModel for Tasks
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TasksToDo")    //Get the CoreDataModel by Name
        
        //Completes the Creation of the CoreDataStack
        container.loadPersistentStores { (_, error) in
            
            //Error Checking
            if let error = error {
                print("Error Loading Persistent Stores in: \(#file): \(#function): \(#line): Error: \(error)")
            }
        }
        
        return container
    }()
    
    //Getting mainContext
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    
    //MARK: - Methods
    func save() {
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            print("Error saving in CoreDataStack: \(error)")
        }
    }
    
    func delete(object: NSManagedObject) {
        CoreDataStack.shared.mainContext.delete(object)
        save()
    }
    
    //Fetch Tasks
    func fetchAllTasks() -> [Task] {
        
        //Fetch Request
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let context = CoreDataStack.shared.mainContext
        
        //Try Fetching all Tasks
        do {
            let tasks = try context.fetch(fetchRequest)
            return tasks
        } catch {
            print("Error Fetching All Tasks in: \(#file): \(#function): \(#line): \(error)")
            return []
        }
    }
}
