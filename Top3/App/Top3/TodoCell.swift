//
//  TodoCell.swift
//  Top3
//
//  Created by Iulian Crisan on 06/05/2020.
//  Copyright © 2020 julianc. All rights reserved.
//

import UIKit
import SnapKit

class TodoCell: UITableViewCell {
    
    var todoIcon: UIImage {
        let iconName = isCompleted ? "largecircle.fill.circle" : "circle"
        let iconColor = isCompleted ? UIColor.systemBlue : UIColor.darkGray
        let iconConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let icon = UIImage(systemName: iconName)?.withConfiguration(iconConfiguration).withTintColor(iconColor).withRenderingMode(.alwaysOriginal)
        
        return icon!
    }
    
    var isCompleted = false {
        didSet {
            checkBox.setImage(todoIcon, for: .normal)
        }
    }
    
    var todo: Todo? {
        didSet {
            if let todo = todo {
                textView.text = todo.title
                isCompleted = todo.isCompleted
            }
        }
    }
    
    var cardView = UIView()
    var textView = UITextView()
    var textChanged: ((UITextView) -> ())?
    var didBeginEditing: (() -> ())?
    var checkBox = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        styleUI()
        checkBox.addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
        textView.addDoneButton(title: "Done", target: self, selector: #selector(tapDoneEditing))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleButton() {
        isCompleted.toggle()
    }
    
    @objc func tapDoneEditing() {
        textView.endEditing(true)
    }
    
}



// MARK: Text View Delegate
extension TodoCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView)
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        didBeginEditing?()
        return true
    }
    
}




// MARK: Done Button
extension UITextView {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        let frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 44.0)
        let toolBar = UIToolbar(frame: frame)//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    
}



// MARK: User interface
extension TodoCell {
    
    func styleUI() {
        styleCell()
        styleCardView()
        styleCheckbox()
        styleTextView()
    }
    
    func styleCell() {
        contentView.backgroundColor = .systemBackground
    }
    
    func styleCardView() {
        contentView.addSubview(cardView)
        cardView.backgroundColor = .secondarySystemBackground
        cardView.layer.cornerRadius = 6
        
        cardView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(22)
            make.right.equalToSuperview().offset(-22)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func styleCheckbox() {
        contentView.addSubview(checkBox)
        checkBox.setImage(todoIcon, for: .normal)
        checkBox.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        checkBox.snp.makeConstraints { (make) in
            make.top.equalTo(cardView).offset(9)
            make.left.equalTo(cardView).offset(12)
        }
    }
    
    func styleTextView() {
        contentView.addSubview(textView)
        textView.text = "Wash car"
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.isScrollEnabled = false
        textView.delegate = self
        textView.backgroundColor = .secondarySystemBackground
        
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 12)
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(cardView).offset(0)
            make.left.equalTo(checkBox.snp.right)
            make.right.equalTo(cardView).offset(0)
            make.bottom.equalTo(cardView).offset(0)
        }
    }
    
}
