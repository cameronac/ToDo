//
//  TaskAddTableViewCell.swift
//  ToDo
//
//  Created by Cameron Collins on 5/23/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

class TaskAddTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier = "addTaskCell"
    var section: Section? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
