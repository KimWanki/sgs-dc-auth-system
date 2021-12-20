//
//  UIStackView+.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/20.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView..., autoResizing: Bool = false) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = autoResizing
            self.addArrangedSubview(view)
        }
    }
}
