//
//  Section.swift
//  ToDo
//
//  Created by Cameron Collins on 5/21/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import Foundation

class Section {
    
    //MARK: - Properties
    var name: String
    var isCollapsed: Bool
    var tasks: [Task?]

    //MARK: - Initializer
    init(name: String, tasks: [Task], isCollapsed: Bool = true) {
        self.name = name
        self.tasks = tasks
        self.isCollapsed = isCollapsed
    }
}
