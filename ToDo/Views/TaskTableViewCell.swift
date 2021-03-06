//
//  TaskTableViewCell.swift
//  ToDo
//
//  Created by Cameron Collins on 5/12/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit
import AudioToolbox

class TaskTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    public var task: Task? {
        didSet {
            setupCell()
        }
    }
    public var coreDataStack: CoreDataStack?
    public var buttonColors = [UIColor.gray, UIColor.systemGreen]
    static let identifier = "taskCell"
    
    //MARK: - Outlets
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    //MARK: - Actions
    
    ///Changes the button image and vibrates the phone
    @IBAction func completeButtonPressed(_ sender: UIButton) {
        
        //Unwrap Task
        guard let task = task else {
            return
        }
        
        task.complete = !task.complete
        
        //Vibrate Phone When Complete is pressed
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        //Unwrapping then saving task to coreDataStack
        guard let coreDataStack = coreDataStack else {
            print("CoreDataStack is nil in TaskTableViewCell can't save changes!")
            return
        }
        coreDataStack.save()
        
        //Change Complete and Assign a New Button Image
        if task.complete == false {
            completeButton.tintColor = buttonColors[0]
            let image = UIImage(systemName: "square")
            sender.setImage(image, for: .normal)
        } else {
            completeButton.tintColor = buttonColors[1]
            let image = UIImage(systemName: "checkmark.square.fill")
            sender.setImage(image, for: .normal)
        }
    }
    
    
    //MARK: - Methods
    
    //MARK: - Private
    
    ///Assigning cellViews properties
    private func setupCell() {
        taskTitle.text = task?.title
        
        //Change Complete and Assign a New Button Image
        if task?.complete == false {
            completeButton.tintColor = buttonColors[0]
            let image = UIImage(systemName: "square")
            completeButton.setImage(image, for: .normal)
        } else {
            completeButton.tintColor = buttonColors[1]
            let image = UIImage(systemName: "checkmark.square.fill")
            completeButton.setImage(image, for: .normal)
        }
    }
    
    //MARK: - Unused Code
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
