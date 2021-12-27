//
//  ViewController.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/19.
//

import UIKit

class SigninViewController: UIViewController {
    let alertManager = AlertManager()

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        autoSigninRequest()
    }
    
    @IBAction func didTapSignInButton() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else { return }
        
        if email.isEmpty || password.isEmpty {
            let alert = self.alertManager.alert(
                message: "아이디 또는 비밀번호를\n아직 입력하지 않았어요.😅")
            self.present(alert, animated: true)
            return
        }
        
        if !email.isValidEmail() {
            let alert = self.alertManager.alert(
                message: "이메일 형식이 잘못되었어요\n정확히 입력해주세요😅")
            self.present(alert, animated: true)
            return
        }
        
        signinRequest(email: email, password: password)
    }
}
extension SigninViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signinSegue" {
            guard let destinationViewController = segue.destination as? HomeViewController,
                  let userInfo = sender as? UserInfo else { return }
            
            destinationViewController.configure(userInfo)
        }
    }
}

extension SigninViewController {
    
    private func checkAdminister(email: String, password: String) -> Bool {
        if let adminEmail = UserDefaults.standard.string(forKey: "adminEmail"),
           let adminPassword = UserDefaults.standard.string(forKey: "adminPassword") {
            if email == adminEmail && adminPassword == password {
                return true
            }
        }
        return false
    }
    
    private func autoSigninRequest() {
        guard let userEmail = UserDefaults.standard.string(forKey: "loginEmail"),
              let userPassword = UserDefaults.standard.string(forKey: "loginPassword")
        else { return }
        
        NetworkServiceManager.shared.request(
            endpoint: "/users/signin",
            signinObject: SigninModel(email: userEmail, password: userPassword)
        ) { [weak self] (result) in
            switch result {
            case .success(let info):
                guard let info = info as? UserInfo else { return }
                
                self?.performSegue(withIdentifier: "signinSegue", sender: info)
                
            case .failure(let error):
                guard let alert = self?.alertManager.alert(message: "로그인 정보가 일치하지 않아요❌\n 정확히 입력해주세요😅") else { return }
                #if DEBUG
                print(error.localizedDescription)
                #endif
                self?.present(alert, animated: true)
            }
        }
    }
    
    private func signinRequest(email: String, password: String) {
        if checkAdminister(email: email, password: password) {
            self.performSegue(withIdentifier: "administerSegue", sender: nil)
            return
        }
        let user = SigninModel(email: email, password: password)
        NetworkServiceManager.shared.request(endpoint: "/users/signin",
                                         signinObject: user) { [weak self] (result) in
            switch result {
            case .success(let info):
                guard let info = info as? UserInfo else { return }
                UserDefaults.standard.set(email, forKey: "loginEmail")
                UserDefaults.standard.set(password, forKey: "loginPassword")

                self?.performSegue(withIdentifier: "signinSegue", sender: info)
                
            case .failure(let error):
                guard let alert = self?.alertManager.alert(message: "로그인 정보가 일치하지 않아요❌\n 정확히 입력해주세요😅") else { return }
                #if DEBUG
                print(error.localizedDescription)
                #endif
                self?.present(alert, animated: true)
            }
        }
    }
}
