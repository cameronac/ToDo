//
//  Task+Convenience.swift
//  ToDo
//
//  Created by Cameron Collins on 5/12/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
    @discardableResult convenience init(title: String?, bodyText: String?, complete: Bool, section: String = "Default", identifier: UUID = UUID(), context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        self.title = title
        self.bodyText = bodyText
        self.complete = complete
        self.section = section
        self.identifier = identifier
    }
}
