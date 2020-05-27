//
//  ThemePickerViewController.swift
//  ToDo
//
//  Created by Cameron Collins on 5/20/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

class ThemePickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
        
        updateViews()
    }
    
    //MARK: - Properties
    static let identifier = "colorSegue"
    public var delegate: TaskTableViewController?
    public var colorController: ColorController?
    
    //MARK: - Outlets
    @IBOutlet weak var colorPickerView: UIPickerView!
    
    //MARK: - Methods
    
    //MARK: - Private Functions
    ///Updates Views
    private func updateViews() {
        
        //Unwrapping
        guard let colorController = colorController, let delegate = delegate else {
            print("Bad delegate or colorController in ThemePicker")
            return
        }

        //Pick Theme
        if delegate.colorFor == 0 {
            colorPickerView.selectRow(colorController.currentColorIndex, inComponent: 0, animated: true)
            setBackgroundColor(index: colorController.currentColorIndex)
        } else if delegate.colorFor == 1 {
            
            //Unwrapping
            guard let sectionIndex = delegate.sectionIndex else {
                return
            }
            
            //Pick Header Color
            colorPickerView.selectRow(delegate.taskController.sections[sectionIndex].colorIndex, inComponent: 0, animated: true)
            setHeaderColor(index: delegate.sectionIndex, colorIndex: nil)
            
        }
    }
    
    ///Set header Color: Using Header/Section Index
    private func setHeaderColor(index: Int?, colorIndex: Int?) {
        
        //Unwrapping
        guard let colorController = colorController, let index = index, let delegate = delegate else {
            print("Bad Variable is nil in: \(#file) \(#function) \(#line)")
            return
        }
    
        //Get Color
        let section = delegate.taskController.sections[index]
        print(index)
        
        //Check Color Index
        if let colorIndex = colorIndex {
            let color = colorController.getUIColor(name: ColorController.colorNames[colorIndex])
            view.backgroundColor = color
            section.viewColor = color
            section.colorIndex = colorIndex
        } else {
            let color = colorController.getUIColor(name: ColorController.colorNames[section.colorIndex])
            view.backgroundColor = color
            section.viewColor = color
        }
    }
    
    ///Sets new Background color for TaskTableViewController and Saves new Color value
    private func setBackgroundColor(index: Int) {
        
        //Unwrapping ColorController
        guard let colorController = colorController, let delegate = delegate else {
            print("Couldn't unwrap colorController in ThemePickerViewController!")
            return
        }
    
        //Get Color
        let color = colorController.getUIColor(name: ColorController.colorNames[index])
        colorController.saveCurrentColor(color: color, index: index)
        
        view.backgroundColor = color
        delegate.navigationController?.navigationBar.barTintColor = color
    }
}


//Picker View Methods
extension ThemePickerViewController {
    
    //Return Number of Sections/Components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Return Color Count
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ColorController.colorNames.count
    }
    
    //Set Titles
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ColorController.colorNames[row]
    }
    
    //Value Changed
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //Unwrapping
        guard let delegate = delegate else {
            print("Bad delegate in ThemePickerViewController!")
            return
        }
        
        //Picker View Pick Theme or Header Color
        if delegate.colorFor == 0 {
            setBackgroundColor(index: row)
            
            //Unwrapping colorController
            guard let colorController = colorController else {
                print("ColorController is nil!")
                return
            }
            
            //Get UIColor
            let optionalColor = ColorController.colors[ColorController.colorNames[row]]
            
            guard let color = optionalColor else {
                print("Color does not exist!")
                return
            }
            
            colorController.saveCurrentColor(color: color, index: row)
        } else if delegate.colorFor == 1 {
            setHeaderColor(index: delegate.sectionIndex, colorIndex: row)
            colorController?.saveHeaderColor(taskTableView: delegate)
        }
    }
    
}
