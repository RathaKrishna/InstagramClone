//
//  RegisterViewController.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 26/04/22.
//

import UIKit
import SafariServices

class RegisterViewController: UIViewController {

    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    /// Initi views
    private let headerImg: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "Instagram")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    private let topLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Sign up to see photos and videos from your friends."
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .secondaryLabel
        lbl.font = .systemFont(ofSize: 16, weight: .bold)
        return lbl
    }()
    
    private let userNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username.."
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
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email.."
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
        field.placeholder = "Password..."
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
    
    private let registerButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 2
        return button
    }()
    
    private let loginLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Have an account? "
        lbl.font = .systemFont(ofSize: 16, weight: .bold)
        return lbl
    }()
    private let loginButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Log in.", for: .normal)
        button.layer.masksToBounds = true
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    lazy var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.contentMode = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        [self.loginLabel, self.loginButton].forEach { stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private let bottomLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "By signing up, you agree to our"
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .secondaryLabel
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        return lbl
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms", for: .normal)
        button.layer.masksToBounds = true
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        return button
    }()
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle(" , Data Policy", for: .normal)
        button.layer.masksToBounds = true
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        return button
    }()
    
    lazy var agreeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.contentMode = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        [self.termsButton, self.privacyButton].forEach { stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(headerImg)
        view.addSubview(topLabel)
        view.addSubview(userNameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        view.addSubview(loginStackView)
        view.addSubview(bottomLabel)
        view.addSubview(agreeStackView)
        
        // delegate
        userNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        //add actions
        loginButton.addTarget(self, action: #selector(didLoginButtonClicked), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTermsButtonClicked), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didPrivacyButtonClicked), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(didRegisterButtonClicked), for: .touchUpInside)
    }
    /// layout subviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerImg.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets.top).offset(40)
            make.centerX.equalToSuperview()
        }
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(headerImg.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        userNameField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(topLabel.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        emailField.snp.makeConstraints { make in
            make.left.right.equalTo(userNameField)
            make.top.equalTo(userNameField.snp.bottom).offset(10)
            make.height.equalTo(44)
        }
        
        passwordField.snp.makeConstraints { make in
            make.left.right.equalTo(userNameField)
            make.top.equalTo(emailField.snp.bottom).offset(10)
            make.height.equalTo(44)
        }
        
        registerButton.snp.makeConstraints { make in
            make.left.right.equalTo(userNameField)
            make.top.equalTo(passwordField.snp.bottom).offset(20)
            make.height.equalTo(44)
        }
        bottomLabel.snp.makeConstraints { make in
            make.left.right.equalTo(userNameField)
            make.top.equalTo(registerButton.snp.bottom).offset(20)
        }
        agreeStackView.snp.makeConstraints { make in
            make.top.equalTo(bottomLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        
        loginStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaInsets.bottom).offset(-30)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
    }
    
    
    //MARK: - Button actions
    @objc func didRegisterButtonClicked() {
        emailField.resignFirstResponder()
        userNameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text , !email.isEmpty,
              let username = userNameField.text , !username.isEmpty,
              let password = passwordField.text , !password.isEmpty,
              password.count >= 6 else {
            return
        }
        
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { success in
            DispatchQueue.main.async {
               
                if success {
                    self.dismiss(animated: true)
                }
                else {
                    // error
                    let alert = UIAlertController(title: "Oops", message: "We were unable to register", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    self.present(alert, animated: true)
                }
                
            }
            
        }
    }
    
    @objc func didLoginButtonClicked() {
        dismiss(animated: true)
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

// MARK: - TextField Delegate
extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didLoginButtonClicked()
        }
        return true
    }
}
