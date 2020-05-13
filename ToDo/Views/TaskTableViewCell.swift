//
//  TaskTableViewCell.swift
//  ToDo
//
//  Created by Cameron Collins on 5/12/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Properties
    var task: Task?
    
    //MARK: - Outlets
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDescription: UITextView!
    
    //MARK: - Actions
    @IBAction func completeButtonPressed(_ sender: UIButton) {
        
        //Unwrap Task
        guard let task = task else {
            return
        }
        
        //TODO: Change Complete Status and Save the Changes
        
        //Change Complete and Assign a New Button Image
        if task.complete == true {
            let image = UIImage(systemName: "square")
            sender.setImage(image, for: .normal)
        } else {
            let image = UIImage(systemName: "checkmark.square.fill")
            sender.setImage(image, for: .normal)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
