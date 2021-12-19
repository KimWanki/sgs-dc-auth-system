//
//  UIView+.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/19.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
