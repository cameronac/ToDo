//
//  TaskRepresentation.swift
//  ToDo
//
//  Created by Cameron Collins on 5/12/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import Foundation

//TaskRepresentation is used to Encode and Decode data we send or get back from firebase
//Since We Can't send CoreData Models
struct TaskRepresentation: Codable {
    var title: String?
    var bodyText: String?
    var completion: Bool
}
