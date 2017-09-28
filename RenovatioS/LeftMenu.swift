//
//  LeftMenu.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/8/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//
// This is the Drawer that slides out from the left. The main component for navigating to different sections of the app. Follow the steps to add items to the list

import Foundation
import Material

class LeftMenu: UIViewController {
    fileprivate var table: TableView = TableView()
    
    //MARK: Step 1
    // When you want to add another option to the menu by adding its title here
    fileprivate var options = ["Sutra", "Meditation", "Further Info", "Acknowledgments"]
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        prepareTable()
    }
}

//MARK: - TableView Methods
extension LeftMenu: UITableViewDelegate, UITableViewDataSource {
    func prepareTable() {
        table = TableView(frame: self.view.frame)
        view = table
        table.delegate = self
        table.backgroundColor = Color.grey.base.withAlphaComponent(0.9)
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        cell.textLabel?.textColor = white
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let option = options[indexPath.row]
        switch option {
        case "Sutra":
            sutraAction()
        case "Meditation":
            meditationAction()
        case "Further Info":
            furtherInfoAction()
        case "Acknowledgments":
            acknowledgmentsAction()
            //MARK: Step 2
        //Add the title here as a case for this switch statement.
            //MARK: Step 4
            // Add a call to the `Action` method created in step 3
        default:
            assertionFailure("The Option: \(options[indexPath.row]) Does not have an `Action` defined for it. Please define an action and add it to this switch statement")
        }
    }
}

//MARK: - Action methods
extension LeftMenu {
    
    fileprivate func closeNavigationDrawer(result: Bool) {
        navigationDrawerController?.closeLeftView()
    }
    
    func sutraAction() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: HomeVC(), completion: closeNavigationDrawer)
    }
    
    func meditationAction() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: SoundsViewController(), completion: closeNavigationDrawer)
    }
    
    func furtherInfoAction() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: MoreInfo(), completion: closeNavigationDrawer)
    }
    
    func acknowledgmentsAction() {
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: TumblerViewController(), completion: closeNavigationDrawer)
    }
    //MARK: Step 3
    // Add a new `Action` method like the ones above for transitioning to the view the new option would like to navigate to.
}
