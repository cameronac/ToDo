//
//  TaskDetailViewController.swift
//  ToDo
//
//  Created by Cameron Collins on 5/12/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        titleLabel.isUserInteractionEnabled = false
        descriptionTextView.isUserInteractionEnabled = false
    }
    
    //MARK: - Properties
    static let identifier = "detailSegue"
    var coreDataStack: CoreDataStack?
    var delegate: TaskTableViewController?
    var task: Task?
    var canEdit: Bool = false

    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    //MARK: - Actions
    
    //Edit the Title and Description Fields| If they changed save the changes
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        
        canEdit = !canEdit
        
        //Allow Editing
        if canEdit == true {
            sender.title = "Done"
            titleLabel.isUserInteractionEnabled = true
            descriptionTextView.isUserInteractionEnabled = true
            animateToGray()
        } else {
            animateToWhite()
            sender.title = "Edit"
            titleLabel.isUserInteractionEnabled = false
            descriptionTextView.isUserInteractionEnabled = false
            
            //Save Changes
            //Unwrapping
            guard let coreDataStack = coreDataStack else {
                print("Received a bad variable coreDataStack: \(#file) \(#function) \(#line)")
                return
            }
            
            task?.title = titleLabel.text
            task?.bodyText = descriptionTextView.text
            
            coreDataStack.save()
            delegate?.updateViews()
        }
    }
    
    //MARK: - Functions
    
    ///Animate to Gray
    func animateToGray() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: [], animations: {
                   //White to Gray
                   UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                    self.titleLabel.backgroundColor = .systemGray3
                    self.descriptionTextView.backgroundColor = .systemGray3
            }
        })
    }
    
    ///Animate to White
    func animateToWhite() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: [], animations: {
                   //White to Gray
                   UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                    self.titleLabel.backgroundColor = .white
                    self.descriptionTextView.backgroundColor = .white
            }
        })
        
    }
    
    
    ///Sets up the Views with properties when viewDidLoad
    func setupView() {
        
        //Unwrapping
        guard let task = task else {
            print("Delegate is nil in:  \(#file) \(#function) \(#line)")
            return
        }
        
        titleLabel.text = task.title
        descriptionTextView.text = task.bodyText
        
        if let date = task.date {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            dateLabel.text = "Date: \(formatter.string(from: date))"
        }
        
        if task.complete == true {
            completedLabel.text = "Status: Completed"
        } else {
            completedLabel.text = "Status: Not Completed"
        }
    }
}
