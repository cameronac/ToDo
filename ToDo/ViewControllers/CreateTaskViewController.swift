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
    var section: Section?
    
    //MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //MARK: - Actions
    @IBAction func createTaskButtonPressed(_ sender: UIButton) {
        
        //Unwrapping delegate
        if let delegate = delegate {
            //Create Task
            delegate.taskController.createTask(title: titleTextField.text ?? "No Title Provided", bodyText: descriptionTextView.text, complete: false, section: section?.name ?? "Default")
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
