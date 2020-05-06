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
        let iconConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let icon = UIImage(systemName: iconName)?.withConfiguration(iconConfiguration).withTintColor(.darkGray).withRenderingMode(.alwaysOriginal)
        
        return icon!
    }
    
    var isCompleted = false {
        didSet {
            checkBox.setImage(todoIcon, for: .normal)
        }
    }
    
    var textView = UITextView()
    var textChanged: ((UITextView) -> Void)?
    var checkBox = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        styleUI()
        checkBox.addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleButton() {
        isCompleted.toggle()
    }
    
}


extension TodoCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView)
    }
    
}



// MARK: User interface
extension TodoCell {
    
    func styleUI() {
        styleCell()
        styleCheckbox()
        styleTextView()
    }
    
    func styleCell() {
        
    }
    
    func styleCheckbox() {
        contentView.addSubview(checkBox)
        checkBox.setImage(todoIcon, for: .normal)
        checkBox.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        checkBox.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(9)
            make.left.equalToSuperview().offset(12)
        }
    }
    
    func styleTextView() {
        contentView.addSubview(textView)
        textView.text = "Custom cell"
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.isScrollEnabled = false
        textView.delegate = self
        
        textView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(checkBox.snp.right)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    //    func styleCardView() {
    //        contentView.addSubview(cardView)
    //        cardView.backgroundColor = .secondarySystemBackground
    //        cardView.layer.cornerRadius = 8
    //
    //        cardView.snp.makeConstraints { (make) in
    //            make.top.equalTo(titleLabel.snp.bottom).offset(22)
    //            make.left.equalTo(contentView).offset(22)
    //            make.right.equalTo(contentView).offset(-22)
    //            make.bottom.equalTo(contentView).offset(-22)
    //            make.height.greaterThanOrEqualTo(60)
    //        }
    //    }
    //
    //    func styleCardButton() {
    //        cardView.addSubview(cardButton)
    //        cardButton.setImage(todoIcon, for: .normal)
    //        cardButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    //
    //        cardButton.snp.makeConstraints { (make) in
    //            make.top.equalTo(cardView).offset(8)
    //            make.left.equalTo(cardView).offset(12)
    //        }
    //    }
    //
    //    func styleCardTitle() {
    //        cardView.addSubview(cardTitleLabel)
    //        cardTitleLabel.text = "Wash the car"
    //        cardTitleLabel.numberOfLines = 0
    //
    //        cardTitleLabel.snp.makeConstraints { (make) in
    //            make.top.equalTo(cardView).offset(19)
    //            make.left.equalTo(cardButton.snp.right)
    //            make.right.equalTo(cardView).offset(-22)
    //            make.bottom.equalTo(cardView).offset(-19)
    //        }
    //    }
    
}
