//
//  CreateTaskViewController.swift
//  ToDo
//
//  Created by Cameron Collins on 5/12/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Properties
    static let identifier = "createTaskSegue"
    var coreDataStack: CoreDataStack?
    var delegate: TaskTableViewController?
    var indexPath: IndexPath?
    var section: Section?
    
    //MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //MARK: - Actions
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
