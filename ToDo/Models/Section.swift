//
//  Section.swift
//  ToDo
//
//  Created by Cameron Collins on 5/21/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

class Section {
    
    //MARK: - Properties
    var name: String
    var isCollapsed: Bool
    var tasks: [Task?]
    var isViewSet: Bool = false
    var delegate: TaskTableViewController
    
    //Created Objects
    var view: UIView? = nil
    let label = UILabel()
    let button = UIButton()
    
    //MARK: - Initializer
    init(name: String, tasks: [Task], isCollapsed: Bool = true, taskTableView: TaskTableViewController) {
        self.name = name
        self.tasks = tasks
        self.isCollapsed = isCollapsed
        self.delegate = taskTableView
        self.setupView()
    }
    
    //MARK: - Methods
    ///Sets up the header view with the appropriate
    private func setupView() {
        
        //Create View
        view = UIView(frame: CGRect(x: 0, y: 0, width: delegate.tableView.frame.width, height: TaskTableViewController.headerHeight))
        
        //Unwrapping
        guard let view = view else {
            print("Bad View in Section!")
            return
        }
        
        //Setting Up Properties
        view.backgroundColor = .systemBlue
        button.setTitle(name, for: .normal)
        button.tintColor = .white
        
        //Set Button Properties
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .center
        button.center = CGPoint(x: 0, y: 0)
        button.tintColor = UIColor.white
        button.setTitle("\(name)", for: .normal)
        button.isUserInteractionEnabled = true
        
        //Add Subviews
        view.addSubview(button)
        
        //Setting up Button Constraints
        let buttonXC = NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0)
        let buttonYC = NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
        let buttonWC = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0)
        let buttonWH = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([buttonXC, buttonYC, buttonWC, buttonWH])
        
        //Adding Target
        button.addTarget(delegate, action: #selector(delegate.sectionButtonPressed(sender:)), for: .touchUpInside)
        
        isViewSet = true
    }
    
    
}
