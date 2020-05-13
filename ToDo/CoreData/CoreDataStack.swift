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
    static var shared = CoreDataStack() //CoreDataStack Object
    
    //Create CoreDataModel for Tasks
    var container: NSPersistentContainer {
        let container = NSPersistentContainer(name: "TasksToDo")    //Get the CoreDataModel by Name
        
        //Completes the Creation of the CoreDataStack
        container.loadPersistentStores { (description, error) in
            
            //Error Checking
            if let error = error {
                print("Error Loading Persistent Stores in: \(#file): \(#function): \(#line): Error: \(error)")
            }
        }
        
        return container
    }
    
    //Getting mainContext
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    
    //MARK: - Methods
    func save() {
        do {
            try mainContext.save()
        } catch {
            print("Error saving in CoreDataStack: \(error)")
        }
    }
}
