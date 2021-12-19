//
//  AlertManager.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/19.
//

import UIKit

class AlertManager {
    
    func alert(message: String) -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        alertController.addAction(action)
        
        return alertController
    }
}
