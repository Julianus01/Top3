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

let TODOS = [
    Todo(title: "Wash car", isCompleted: true),
    Todo(title: "Get groceries", isCompleted: false),
    Todo(title: "Learn swift", isCompleted: false)
]

let TODOS_TOMORROW = [
    Todo(title: "Tomorrow", isCompleted: true),
    Todo(title: "Tomorrow Get groceries", isCompleted: false),
    Todo(title: "Tomorrow Learn swift", isCompleted: false)
]

let TODOS_ALL = [
    TODOS,
    TODOS_TOMORROW,
]

class Top3VC: UIViewController {
    
    let TODO_CELL = "TODO_CELL"
    var tableView = UITableView(frame: .zero, style: .grouped)
    var todos: [Todo] = TODOS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleUI()
        title = "Top3"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}


// MARK: Table Functionality
extension Top3VC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TODO_CELL) as! TodoCell
        cell.selectionStyle = .none
        
        cell.todo = TODOS_ALL[indexPath.section][indexPath.row]
        
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.text = section == 0 ? "Today" : "Tomorrow"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        view.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(22)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TODOS_ALL[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TODOS_ALL.count
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
        tableView.backgroundColor = .systemBackground
        
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
