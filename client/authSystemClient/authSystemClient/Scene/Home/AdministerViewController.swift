//
//  AdministerViewController.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/20.
//

import UIKit

class AdministerViewController: UIViewController {
    var userList: [PrivateInfo] = []
    
    private var userTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        userTableView.dataSource = self
        userTableView.register(UserTableViewCell.self,
                           forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        requestUserList()
        
        self.userTableView.reloadData()
    }
    
    func requestUserList() {
        NetworkServiceManager.shared.request(endpoint: "/users") { [weak self] (result) in
            switch result {
            case .success(let info):
                guard let info = info as? [PrivateInfo] else { return }
                self?.userList = info
                
            case .failure(let error):
                #if DEBUG
                print(error.localizedDescription)
                #endif
            }
        }
    }
}
extension AdministerViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubviews(userTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            userTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            userTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            userTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            userTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

extension AdministerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier) as? UserTableViewCell else { fatalError()}
        
        cell.configure(userList[indexPath.row])
        
        return cell
    }
    
    
}


