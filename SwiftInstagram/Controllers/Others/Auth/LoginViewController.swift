//
//  LoginViewController.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 26/04/22.
//

import UIKit
import FirebaseAuth
import SnapKit
import SafariServices

class LoginViewController: UIViewController {

    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    private let userNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Username or Email.."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground

        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Enter Password"
        field.returnKeyType = .done
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
   
        return field
    }()
    
    private let forgotButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Forgot Password?", for: .normal)
        button.layer.masksToBounds = true
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private let loginButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 2
        return button
    }()
    
    private let registerLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Don't have an account? "
        lbl.textColor = .secondaryLabel
        lbl.font = .systemFont(ofSize: 15)
        return lbl
    }()
    private let registerButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Sing Up.", for: .normal)
        button.layer.masksToBounds = true
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()
    
    private let agreeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Instagram from Facebook"
        lbl.textColor = .secondaryLabel
        lbl.font = .systemFont(ofSize: 12)
        return lbl
    }()
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms", for: .normal)
        button.layer.masksToBounds = true
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle(" & Privacy", for: .normal)
        button.layer.masksToBounds = true
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    private let headerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    private let headerImg: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "header_icon")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    lazy var registerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.contentMode = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        [self.registerLabel, self.registerButton].forEach { stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    lazy var agreeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.contentMode = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        [self.agreeLabel, self.termsButton, self.privacyButton].forEach { stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addViews()
    }
    
    private func addViews() {
        view.addSubview(headerView)
        view.addSubview(userNameField)
        view.addSubview(passwordField)
        view.addSubview(forgotButton)
        view.addSubview(loginButton)
        view.addSubview(registerStackView)
        view.addSubview(agreeStackView)
//        view.addSubview(privacyButton)
        headerView.addSubview(headerImg)
        
        userNameField.delegate = self
        passwordField.delegate = self
        
        registerButton.addTarget(self, action: #selector(didRegisterButtonClicked), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didLoginButtonClicked), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTermsButtonClicked), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didPrivacyButtonClicked), for: .touchUpInside)
        forgotButton.addTarget(self, action: #selector(didForgotButtonClicked), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets.top).offset(40)
            make.height.equalTo(200)
            make.width.equalToSuperview()
        }
        headerImg.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.center.equalTo(headerView)
        }
        
        userNameField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(headerView.snp.bottom)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        passwordField.snp.makeConstraints { make in
            make.left.right.equalTo(userNameField)
            make.top.equalTo(userNameField.snp.bottom).offset(10)
            make.height.equalTo(44)
        }
        
        forgotButton.snp.makeConstraints { make in
            make.right.equalTo(userNameField)
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        loginButton.snp.makeConstraints { make in
            make.left.right.equalTo(userNameField)
            make.top.equalTo(forgotButton.snp.bottom).offset(20)
            make.height.equalTo(44)
        }
        registerStackView.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
        
        agreeStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaInsets.bottom).offset(-30)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Button actions
    @objc func didRegisterButtonClicked() {
        let vc = RegisterViewController()
        present(vc, animated: true)
    }
    @objc func didForgotButtonClicked() {
        try? Auth.auth().signOut()
    }
    @objc func didLoginButtonClicked() {
        
        passwordField.resignFirstResponder()
        userNameField.resignFirstResponder()
        
        guard let usernameEmail = userNameField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 6 else {
            return
        }
        var username: String?
        var email: String?
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            email = usernameEmail
        }
        else {
            username = usernameEmail
        }
        // do login
        AuthManager.shared.loginUser(username: username, email: email, password: password) { result in
            DispatchQueue.main.async {
                if result {
                    //user logged in
                    self.dismiss(animated: true)
                } else {
                    // error
                    let alert = UIAlertController(title: "Oops", message: "We were unable to login", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    self.present(alert, animated: true)
                }
            }
            
        }
    }
    @objc func didTermsButtonClicked() {
        
        guard let url = URL(string: "https://help.instagram.com/581066165581870/?helpref=uf_share") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    @objc func didPrivacyButtonClicked() {
        guard let url = URL(string: "https://help.instagram.com/519522125107875/?helpref=uf_share") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didLoginButtonClicked()
        }
        return true
    }
}
