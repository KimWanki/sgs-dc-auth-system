//
//  SignupViewController.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/19.
//

import UIKit

class SignupEmailViewController: UIViewController {
    let networkingServiceManager = NetworkServiceManager()
    let alertManager = AlertManager()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일을 입력해주세요."
        return label
    }()
    
    lazy var textField: UITextField = {
        let view = UITextField.init(frame: .zero)
        view.inputAccessoryView = accessoryView
        view.placeholder = "ID@example.com"
        view.textAlignment = .left
        
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: view.frame.height))
        view.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: view.frame.height))
        view.leftViewMode = .always
        view.rightViewMode = .always
        
        view.layer.borderColor = UIColor.systemGray6.cgColor
        
        return view
    }()
    
    lazy var accessoryView: UIView = {
        return UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 56))
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .systemBlue.withAlphaComponent(0.7)
        
        button.layer.cornerRadius = 7.0
        button.layer.borderWidth = .zero
        button.layer.borderColor = UIColor.systemGray.cgColor
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture()
        applyViewSettings()
        textField.becomeFirstResponder()
        confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func didTapCancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - User Event
extension SignupEmailViewController {
    @objc
    private func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @objc
    private func didTapConfirmButton(_ sender: Any) {
        guard let email = self.textField.text
        else { return }
        if email.isValidEmail() {
            checkExisted(email: email)
        } else {
            self.emailLabel.text = "이메일 형식이 유효하지 않아요\n"
        }
    }
}

extension SignupEmailViewController {
    private func checkExisted(email: String) {
        networkingServiceManager.request(endpoint: "/users/check/",
                                         checkObject: email
                                  ) { [weak self] (result) in
            switch result {
            case .success(_):
                    self?.performSegue(withIdentifier: "signupPasswordSegue", sender: email)
            case .failure(_):
                guard let alert = self?.alertManager.alert(message: "중복된 이메일이 있어 가입이 불가능합니다.")
                else { return }
                
                self?.present(alert, animated: true)
            }
        }
    }
}

// MARK: - ViewConfiguration
extension SignupEmailViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubviews(emailLabel, textField)
        accessoryView.addSubviews(confirmButton)
    }
    
    func setupConstraints() {
        guard let confirmButtonSuperview = confirmButton.superview else { return }
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            emailLabel.heightAnchor.constraint(equalToConstant: 30),
            
            textField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            textField.heightAnchor.constraint(equalToConstant: 45),
            
            confirmButton.leadingAnchor.constraint(equalTo: confirmButtonSuperview.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: confirmButtonSuperview.trailingAnchor, constant: -16),
            confirmButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
