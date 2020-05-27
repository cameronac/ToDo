//
//  CreateTaskViewController.swift
//  ToDo
//
//  Created by Cameron Collins on 5/12/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {
    
    //MARK: - Properties
    static let identifier = "createTaskSegue"
    public var delegate: TaskTableViewController?
    public var indexPath: IndexPath?
    
    //MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    //MARK: - Actions
    
    ///Creates a Task when the Button is pressed if section is not nil
    @IBAction func createTaskButtonPressed(_ sender: UIButton) {
        
        //Unwrapping delegate
        if let delegate = delegate {
            
            guard let indexPath = indexPath else {
                print("Could not add a task to a nil section: \(#file) \(#function) \(#line)")
                return
            }
            
            //Create Task
            delegate.taskController.createTask(title: titleTextField.text ?? "No Title Provided", bodyText: descriptionTextView.text, complete: false, section: delegate.taskController.sections[indexPath.section].name)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Unused Code
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
