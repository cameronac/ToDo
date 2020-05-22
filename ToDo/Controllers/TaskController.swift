//
//  TaskController.swift
//  ToDo
//
//  Created by Cameron Collins on 5/21/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import Foundation

class TaskController {
    
    //MARK: - Properties
    private var sections: [String] = [] //Holds all Sections
    private var tasks: [[Task]] = [] //Holds all Tasks in a 2D array
    
    //MARK: - Methods
    func getSectionCount() -> Int {
        
        //Need at least 1 section
        if sections.count < 1 {
            return 1
        } else {
            return sections.count
        }
    }
    
    func getTaskCount() -> Int {
        return tasks.count
    }
    
    ///Fetches and Saves Tasks to Tasks Variable
    func fetchTasks() {
        
    }
    
    
}
