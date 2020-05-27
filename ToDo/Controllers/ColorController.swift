//
//  ColorController.swift
//  ToDo
//
//  Created by Cameron Collins on 5/20/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit


class ColorController {
    
    //MARK: - Properties
    public var currentColor: UIColor = UIColor.systemIndigo
    public var currentColorIndex: Int = 5
    
    static let colors: [String: UIColor] = ["Red": UIColor.systemRed, "Blue": UIColor.systemBlue, "Gray": UIColor.systemGray, "Pink": UIColor.systemPink, "Teal": UIColor.systemTeal, "Indigo": UIColor.systemIndigo, "Orange": UIColor.systemOrange, "Purple": UIColor.systemPurple, "Yellow": UIColor.systemYellow, "Green": UIColor.systemGreen]
    
    static let colorNames: [String] = ["Red", "Blue", "Gray", "Pink", "Teal", "Indigo", "Orange", "Purple", "Yellow", "Green"]
    
    //MARK: - Methods
    
    //MARK: - Get Color Elements
    ///Returns a UIColor by getting the name of the color.
    public func getUIColor(name: String) -> UIColor {
        let color = ColorController.colors[name]
        
        //Unwrapping Color
        guard let tempColor = color else {
            print("Error while unwrapping color in ColorController")
            return UIColor.systemIndigo
        }
        
        return tempColor
    }
    
    ///Returns Colors index using a color name
    public func getColorIndex(name: String) -> Int {
        
        for i in 0...ColorController.colorNames.count {
            if name == ColorController.colorNames[i] {
                return i
            }
        }
        
        return 0
    }
    
    //MARK: - Save Colors
    ///Saves newly selected color in UserDefaults. Updates currentColor and currentColorIndex variables.
    public func saveCurrentColor(color: UIColor, index: Int) {
        
        //Set Current Color and Index
        currentColor = color
        currentColorIndex = index
        
        //Save Index in UserDefaults
        let userDefaults = UserDefaults.standard
        userDefaults.set(currentColorIndex, forKey: "Color")
    }
    
    ///Saves Header Colors in UserDefaults
    public func saveHeaderColor(taskTableView: TaskTableViewController?) {
        //Unwrapping
        guard let delegate = taskTableView else {
            return
        }
        
        var headerColors: [Int] = []
        
        //Place all header colors into an array
        for i in delegate.taskController.sections {
            headerColors.append(i.colorIndex)
        }
        
        //Save Header Colors
        let userDefaults = UserDefaults.standard
        userDefaults.set(headerColors, forKey: "headerColors")
    }
    
    //MARK: - Get Saved Colors
    ///Gets the saved color from UserDefaults and then returns UIColor. Updates currentColor and currentColorIndex variables.
    public func getSavedColor() -> UIColor {
        
        //Get UserDefaults Color
        let userDefaults = UserDefaults.standard
        let index = userDefaults.integer(forKey: "Color")
        
        //Get Color
        let colorName = ColorController.colorNames[index]
        let color = ColorController.colors[colorName]
        
        //Unwrapping
        guard let colorTemp = color else {
            print("Color Temp returned nil in ColorController: \(#function)")
            return UIColor.systemIndigo 
        }
        
        //Set Current Color and Index
        currentColor = colorTemp
        currentColorIndex = index
        
        return colorTemp
    }
    
    ///Get Saved Header Colors from UserDefaults
    public func getSavedHeaderColors(taskTableView: TaskTableViewController?) -> [Int] {
        //User Defaults
        let userDefaults = UserDefaults.standard
        let headerColors = userDefaults.array(forKey: "headerColors")
        
        guard let tempHeaderColors = headerColors as? [Int] else {
            print("Could not downcast HeaderColors to type INT in Color Controller!")
            return []
        }
        
        return tempHeaderColors
    }
    
}
