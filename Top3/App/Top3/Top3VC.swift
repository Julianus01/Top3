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
    
    var titleLabel = UILabel()
    var scrollView = UIScrollView()
    var contentView = UIView()
    var cardView = UIView()
    var cardButton = UIButton(type: .system)
    var cardTitleLabel = UILabel()
    var todoIcon: UIImage {
        let iconName = isCompleted ? "largecircle.fill.circle" : "circle"
        let iconConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let icon = UIImage(systemName: iconName)?.withConfiguration(iconConfiguration).withTintColor(.darkGray).withRenderingMode(.alwaysOriginal)
        
        return icon!
    }
    var isCompleted = false {
        didSet {
            cardButton.setImage(todoIcon, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleUI()
        title = "Top3"
        titleLabel.text = "Today"
        cardButton.addTarget(self, action: #selector(testFunc), for: .touchUpInside)
    }
    
    @objc func testFunc() {
        isCompleted.toggle()
    }
    
}




// MARK: USER INTERFACE
extension Top3VC {
    
    func styleUI(){
        styleVC()
        styleScrollView()
        styleContentView()
        styleTitle()
        styleCardView()
        styleCardButton()
        styleCardTitle()
    }
    
    func styleVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func styleScrollView() {
        view.addSubview(scrollView)
        scrollView.alwaysBounceVertical = true
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(view)
        }
    }
    
    func styleContentView() {
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView)
            make.left.equalTo(scrollView)
            make.right.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
    }
    
    func styleTitle() {
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(32)
            make.left.equalTo(contentView).offset(22)
            make.right.equalTo(contentView).offset(-22)
        }
    }
    
    func styleCardView() {
        contentView.addSubview(cardView)
        cardView.backgroundColor = .secondarySystemBackground
        cardView.layer.cornerRadius = 8
        
        cardView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(22)
            make.left.equalTo(contentView).offset(22)
            make.right.equalTo(contentView).offset(-22)
            make.bottom.equalTo(contentView).offset(-22)
            make.height.greaterThanOrEqualTo(60)
        }
    }
    
    func styleCardButton() {
        cardView.addSubview(cardButton)
        cardButton.setImage(todoIcon, for: .normal)
        cardButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        cardButton.snp.makeConstraints { (make) in
            make.top.equalTo(cardView).offset(8)
            make.left.equalTo(cardView).offset(12)
        }
    }
    
    func styleCardTitle() {
        cardView.addSubview(cardTitleLabel)
        cardTitleLabel.text = "Wash the car"
        cardTitleLabel.numberOfLines = 0
        
        cardTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cardView).offset(19)
            make.left.equalTo(cardButton.snp.right)
            make.right.equalTo(cardView).offset(0)
            make.bottom.equalTo(cardView).offset(-19)
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
