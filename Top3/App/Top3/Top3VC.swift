//
//  Top3VC.swift
//  Top3
//
//  Created by Iulian Crisan on 03/05/2020.
//  Copyright © 2020 julianc. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import SnapKit

class Top3VC: UIViewController {
    
    let TODO_CELL = "TODO_CELL"
    var tableView = UITableView(frame: .zero, style: .grouped)
    var todos: [[Todo]] = []
    var editingTextViewIndexPath: IndexPath = IndexPath()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleUI()
        getTodos { (todos) in
            self.todos = todos
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        tableView.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(statusBarHeight)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        cell.todo = todos[indexPath.section][indexPath.row]
        
        cell.textSizeChanged = { [weak tableView] in
            tableView?.beginUpdates()
            tableView?.endUpdates()
            tableView?.scrollToRow(at: indexPath, at: .none, animated: true)
        }
        
        cell.didBeginEditing = {
            self.editingTextViewIndexPath = indexPath
        }
        
        cell.didEndEditing = { (textView: UITextView) in
            print("Done editing")
            print("New text is '\(textView.text!)'")
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
        return todos[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return todos.count
    }
    
}




// MARK: Keyboard
extension Top3VC {
    
    @objc func keyboardWillAppear(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let newHeight: CGFloat
        
        if #available(iOS 11.0, *) {
            newHeight = keyboardSize.height - view.safeAreaInsets.bottom
        } else {
            newHeight = keyboardSize.height
        }
        
        let contentInsets = UIEdgeInsets(top: 20, left: 0.0, bottom: newHeight, right: 0.0)
        self.tableView.contentInset = contentInsets
        self.tableView.scrollIndicatorInsets = contentInsets
        self.tableView.scrollToRow(at: self.editingTextViewIndexPath, at: .none, animated: true)
        
        var rect = self.view.frame
        rect.size.height -= keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
}



// MARK: API
extension Top3VC {
    
    func getTodos(completion: @escaping ([[Todo]]) -> ()) {
        let todayDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = 1
        let tomorrowDate = Calendar.current.date(byAdding: dateComponent, to: todayDate)!
        
        getTodosOnDate(date: todayDate) { (todayResponse: [Todo]) in
            self.getTodosOnDate(date: tomorrowDate) { (tomorrowResponse: [Todo]) in
                var todayTodos = todayResponse
                var tomorrowTodos = tomorrowResponse
                
                if todayTodos.count < 3 {
                    for _ in 1...3 - todayTodos.count {
                        todayTodos.append(Todo(id: "1", title: "", isCompleted: false))
                    }
                }
                
                if tomorrowTodos.count < 3 {
                    for _ in 1...3 - tomorrowTodos.count {
                        tomorrowTodos.append(Todo(id: "1",title: "", isCompleted: false))
                    }
                }
                
                completion([todayTodos, tomorrowTodos])
            }
        }
    }
    
    func getTodosOnDate(date: Date, completion: @escaping ([Todo]) -> Void) {
        db.collection("todos").whereField("createdAt", isDateInToday: date).getDocuments() { (snapshot: QuerySnapshot?, error: Error?) in
            if let error = error {
                print("ERROR get TODOS \(error)")
                return
            }
            
            var todos: [Todo] = []
            
            snapshot!.documents.forEach { (document: QueryDocumentSnapshot) in
                let todo = Todo.init(data: document.data())!
                todos.append(todo)
            }
            
            completion(todos)
        }
    }
    
}

extension CollectionReference {
    func whereField(_ field: String, isDateInToday value: Date) -> Query {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: value)
        guard
            let start = Calendar.current.date(from: components),
            let end = Calendar.current.date(byAdding: .day, value: 1, to: start)
        else {
            fatalError("Could not find start date or calculate end date.")
        }
        
        return whereField(field, isGreaterThan: start).whereField(field, isLessThan: end)
    }
}




// MARK: USER INTERFACE
extension Top3VC {
    
    func styleUI(){
        styleVC()
        styleTableView()
    }
    
    func styleVC() {
        title = "Top3"
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
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
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
