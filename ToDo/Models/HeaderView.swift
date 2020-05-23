//
//  HeaderView.swift
//  ToDo
//
//  Created by Cameron Collins on 5/22/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

class HeaderView {
    
    //MARK: - Properties
    let view = UIView()
    let button = UIButton()
    let label = UILabel()
    var header: UITableViewHeaderFooterView? {
        willSet {
            //Unwrapping Header
            guard let value = newValue else {
                print("Bad header assigned in HeaderView!")
                return
            }
            
            setup(header: value, name: name)
        }
    }
    let name: String
    
    //MARK: - Initializer
    init(name: String) {
        self.name = name
    }
    
    //MARK: - Methods
    ///Sets up header view with buttons and label collapse indicator
    func setup(header: UITableViewHeaderFooterView, name: String) {
        
        //Set View Properties
        view.frame = CGRect(x: 0, y: 0, width: header.frame.width, height: header.frame.height)
        view.backgroundColor = UIColor.orange
        
        //Set Label Properties
        label.textColor = UIColor.white
        label.text = "↓"
        label.frame = CGRect(x: header.frame.maxX * 0.92, y: 0, width: header.frame.width, height: header.frame.height)
        
        //Set Button Properties
        button.contentHorizontalAlignment = .left
        button.center = CGPoint(x: 0, y: 0)
        button.tintColor = UIColor.white
        button.setTitle("\(name)", for: .normal)
        button.frame = CGRect(x: 15, y: 0, width: header.frame.width, height: header.frame.height)
        button.isUserInteractionEnabled = true
        
        //Adding Views as Subviews
        header.addSubview(view)
        view.addSubview(label)
        view.addSubview(button)
    }    
}
