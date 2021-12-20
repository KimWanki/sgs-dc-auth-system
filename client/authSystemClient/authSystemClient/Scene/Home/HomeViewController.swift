//
//  HomeViewController.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/19.
//

import UIKit

class HomeViewController: UIViewController {
    private var userInfo: UserInfo?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.nameLabel.text = userInfo?.privateInfo.nickname
        print(userInfo)
    }

    func configure(_ userInfo : UserInfo) {
        self.userInfo = userInfo
    }
    
    @IBAction func didTapCancelButton(_ sender: UIBarButtonItem) {
        print("click Button")
        self.navigationController?.popViewController(animated: true)
    }
}
