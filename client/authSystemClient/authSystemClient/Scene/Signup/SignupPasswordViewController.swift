//
//  SignupPwViewController.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/20.
//

import UIKit

class SignupPasswordViewController: UIViewController {
    let alertManager = AlertManager()
    
    var currentInfo = [String: Any]()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "사용할 비밀번호를 입력해주세요."
        return label
    }()
    
    lazy var textField: UITextField = {
        let view = UITextField.init(frame: .zero)
        view.inputAccessoryView = accessoryView
        view.placeholder = "비밀번호"
        view.textAlignment = .left
        view.textContentType = .newPassword

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
        print(currentInfo)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func didTapCancelButton(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - User Event
extension SignupPasswordViewController {
    @objc
    private func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @objc
    private func didTapConfirmButton(_ sender: Any) {
        guard let password = self.textField.text,
              password.count > 7
        else {
            let alert = self.alertManager.alert(message: "8자리 이상으로 설정해주세요")

            self.present(alert, animated: true)
            return
        }
        self.performSegue(withIdentifier: "signupNameSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signupNameSegue" {
            if let destinationViewController = segue.destination as? SignupNameViewController,
               let password = self.textField.text {
                self.currentInfo["password"] = password
                destinationViewController.currentInfo = self.currentInfo
            }
        }
    }
}

// MARK: - ViewConfiguration
extension SignupPasswordViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubviews(passwordLabel, textField)
        accessoryView.addSubviews(confirmButton)
    }
    
    func setupConstraints() {
        guard let confirmButtonSuperview = confirmButton.superview else { return }
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordLabel.heightAnchor.constraint(equalToConstant: 30),
            
            textField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            textField.heightAnchor.constraint(equalToConstant: 45),
            
            confirmButton.leadingAnchor.constraint(equalTo: confirmButtonSuperview.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: confirmButtonSuperview.trailingAnchor, constant: -16),
            confirmButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
