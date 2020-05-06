//
//  Top3VC.swift
//  Top3
//
//  Created by Iulian Crisan on 03/05/2020.
//  Copyright © 2020 julianc. All rights reserved.
//

import UIKit
import FirebaseAuth
import SnapKit

class Top3VC: UIViewController {
    
    let TODO_CELL = "TODO_CELL"
    var tableView = UITableView()
    var todos: [Todo] = [Todo(title: "Wash car", isCompleted: true), Todo(title: "Get groceries", isCompleted: false), Todo(title: "Learn swift", isCompleted: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleUI()
        title = "Top3"
    }
    
}


// MARK: Table Functionality
extension Top3VC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TODO_CELL) as! TodoCell
        cell.selectionStyle = .none
        cell.todo = todos[indexPath.row]
        
        cell.textChanged = { [weak tableView] (textView: UITextView) in
            let size = textView.bounds.size
            let newSize = textView.sizeThatFits(CGSize(width: size.width, height: .infinity))
            
            if size.height != newSize.height {
                tableView?.beginUpdates()
                tableView?.endUpdates()
            }
        }
        
        return cell
    }
    
}




// MARK: USER INTERFACE
extension Top3VC {
    
    func styleUI(){
        styleVC()
        styleTableView()
    }
    
    func styleVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func styleTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TodoCell.self, forCellReuseIdentifier: TODO_CELL)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 60
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}


extension UIColor {
    static var opposite: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traits) -> UIColor in
                return traits.userInterfaceStyle == .dark ?
                    .white :
                    .black
            }
        }
        
        return .black
    }
}
