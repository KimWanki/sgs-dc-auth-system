//
//  SignupViewController.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/19.
//

import UIKit

class SignupViewController: UIViewController {
    
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
    
    @objc
    private func didTapConfirmButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTapGesture()
        addSubviews()
        makeConstraints()
        textField.becomeFirstResponder()
    }

    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        view.addGestureRecognizer(tapGesture)
    }

    @objc
    private func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }

    private func addSubviews() {
        view.addSubviews(emailLabel, textField)
        accessoryView.addSubview(confirmButton)
    }

    private func makeConstraints() {

        guard let confirmButtonSuperview = confirmButton.superview else { return }
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.translatesAutoresizingMaskIntoConstraints = false

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
    
    @IBAction func didTapCancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
