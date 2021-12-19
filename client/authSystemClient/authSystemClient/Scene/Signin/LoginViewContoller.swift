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
        
        if email.isEmpty || password.isEmpty {
            let alert = self.alertManager.alert(message: "아이디 또는 비밀번호를\n아직 입력하지 않았어요.😅")
            self.present(alert, animated: true)
            return
        }
        
        if !email.isValidEmail() {
            let alert = self.alertManager.alert(message: "이메일 형식이 잘못되었어요\n정확히 입력해주세요😅")
            self.present(alert, animated: true)
            return
        }
        
        signinRequest(email: email, password: password)
    }
}

extension SigninViewController {
    private func signinRequest(email: String, password: String) {
        let user = SigninModel(email: email, password: password)
        networkingServiceManager.request(endpoint: "/users/signin",
                                         signinObject: user) { [weak self] (result) in
            switch result {
            case .success(let key):
                self?.performSegue(withIdentifier: "signinSegue", sender: key)
                
            case .failure(let error):
                guard let alert = self?.alertManager.alert(message: "로그인 정보가 일치하지 않아요❌\n 정확히 입력해주세요😅") else { return }
                #if DEBUG
                print(error.localizedDescription)
                #endif
                self?.present(alert, animated: true)
            }
        }
    }
    
    private func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
     }
}
