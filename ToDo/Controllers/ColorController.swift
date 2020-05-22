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
    var currentColor: UIColor = UIColor.systemIndigo
    var currentColorIndex: Int = 5
    
    var colors: [String: UIColor] = ["Red": UIColor.systemRed, "Blue": UIColor.systemBlue, "Gray": UIColor.systemGray, "Pink": UIColor.systemPink, "Teal": UIColor.systemTeal, "Indigo": UIColor.systemIndigo, "Orange": UIColor.systemOrange, "Purple": UIColor.systemPurple, "Yellow": UIColor.systemYellow, "Green": UIColor.systemGreen]
    
    var colorNames: [String] = ["Red", "Blue", "Gray", "Pink", "Teal", "Indigo", "Orange", "Purple", "Yellow", "Green"]
    
    //MARK: - Methods
    
    ///Returns a UIColor by getting the name of the color.
    func getUIColor(name: String) -> UIColor {
        let color = colors[name]
        
        //Unwrapping Color
        guard let tempColor = color else {
            print("Error while unwrapping color in ColorController")
            return UIColor.systemIndigo
        }
        
        return tempColor
    }
    
    ///Saves newly selected color in UserDefaults. Updates currentColor and currentColorIndex variables.
    func saveCurrentColor(color: UIColor, index: Int) {
        
        //Set Current Color and Index
        currentColor = color
        currentColorIndex = index
        
        //Save Index in UserDefaults
        let userDefaults = UserDefaults.standard
        userDefaults.set(currentColorIndex, forKey: "Color")
    }
    
    ///Gets the saved color from UserDefaults and then returns UIColor. Updates currentColor and currentColorIndex variables.
    func getSavedColor() -> UIColor {
        //Get UserDefaults Color
        let userDefaults = UserDefaults.standard
        let index = userDefaults.integer(forKey: "Color")
        
        //Get Color
        let colorName = colorNames[index]
        let color = colors[colorName]
        
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
}
