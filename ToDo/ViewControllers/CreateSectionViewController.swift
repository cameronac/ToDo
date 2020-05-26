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
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
    }
    
    //MARK: - Properties
    var delegate: TaskTableViewController?
    static let identifier = "createSectionSegue"
    
    //MARK: - Outlets
    @IBOutlet weak var sectionTextField: UITextField!
    @IBOutlet weak var colorPickerView: UIPickerView!
    
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


extension CreateSectionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //1 Components in the colorPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Return the number of colors in a row
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let delegate = delegate else {
            print("Delegate in CreateSectionViewController is nil!")
            return 0
        }
        
        return delegate.colorController.colorNames.count
    }
    
    //Setting pickerView title
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Nothing"
    }
    
    
}
