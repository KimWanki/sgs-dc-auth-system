//
//  CustomTextField.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/19.
//

import Foundation

import UIKit

final class CustomTextField: UITextField {

    private lazy var underlintView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .gray
        
        return uiView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
}

// MARK: - View Configuration
extension CustomTextField: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(underlintView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            underlintView.leadingAnchor.constraint(equalTo: leadingAnchor),
            underlintView.trailingAnchor.constraint(equalTo: trailingAnchor),
            underlintView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
        ])
    }
    
    func configureViews() {
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [.foregroundColor : UIColor(white: 0, alpha: 0.3)])
    }
}
