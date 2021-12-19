//
//  ViewController.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/19.
//

import UIKit

class SigninViewController: UIViewController {
    let networkingServiceManager = NetworkServiceManager()
    let alertManager = AlertManager()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func didTapSignInButton() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else { return }
        
        signinRequest(email: email, password: password)
    }
}

extension SigninViewController {
    private func signinRequest(email: String, password: String) {
        let user = SigninModel(email: email, password: password)
        networkingServiceManager.request(endpoint: "/users/signin",
                                  loginObject: user) { [weak self] (result) in
            switch result {
            case .success(let key):
                self?.performSegue(withIdentifier: "signinSegue", sender: key)
                
            case .failure(let error):
                guard let alert = self?.alertManager.alert(message: "로그인 정보가 일치하지 않습니다!\n 정확히 입력해주세요!") else { return }
                #if DEBUG
                print(error.localizedDescription)
                #endif
                self?.present(alert, animated: true)
            }
        }
    }
}
