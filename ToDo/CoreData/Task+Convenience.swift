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
    
    @discardableResult convenience init(title: String?, bodyText: String?, complete: Bool, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        self.title = title
        self.bodyText = bodyText
        self.complete = complete
    }
}
