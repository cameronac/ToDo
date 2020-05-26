//
//  CreateSectionViewController.swift
//  ToDo
//
//  Created by Cameron Collins on 5/22/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

class CreateSectionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Properties
    var delegate: TaskTableViewController?
    static let identifier = "createSectionSegue"
    
    //MARK: - Outlets
    @IBOutlet weak var sectionTextField: UITextField!
    
    ///Creates a section when the button is pressed
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        //Unwrapping TextField.text
        guard let text = sectionTextField.text else {
            print("SectionTextField nil when creating section")
            return
        }
        
        delegate?.taskController.createASection(name: text)
        dismiss(animated: true, completion: nil)
    }
}
