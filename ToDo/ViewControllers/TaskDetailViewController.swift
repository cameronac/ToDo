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
    //@IBOutlet weak var completedButton: UIButton!
    
    //MARK: - Actions
    @IBAction func completeButtonPressed(_ sender: UIButton) {
        //TODO
    }
    
    //Edit the Title and Description Fields| If they changed save the changes
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        
        canEdit = !canEdit
        
        //Allow Editing
        if canEdit == true {
            sender.title = "Done"
            titleLabel.isUserInteractionEnabled = true
            descriptionTextView.isUserInteractionEnabled = true
        } else {
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
    func setupView() {
        
        //Unwrapping
        guard let task = task else {
            print("Delegate is nil in:  \(#file) \(#function) \(#line)")
            return
        }
        
        titleLabel.text = task.title
        descriptionTextView.text = task.bodyText
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
