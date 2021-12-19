//
//  ViewConfigure.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/19.
//

import Foundation

protocol ViewConfiguration {
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewConfiguration {
    func configureViews() {}
    
    func applyViewSettings() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
}
