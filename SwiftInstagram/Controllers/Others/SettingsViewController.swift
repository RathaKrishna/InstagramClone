//
//  SettingsViewController.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 26/04/22.
//

import UIKit
import FirebaseAuth
import SafariServices

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

/// View controller to show user info and settings
final class SettingsViewController: UIViewController {
    
    private let tableview: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var data = [[SettingCellModel]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
        configureModels()
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableview.frame = view.bounds
    }
    
    private func configureModels() {
        
        data.append([
            SettingCellModel(title: "Edit Profile", handler: { [weak self] in
                self?.editProfile()
            }),
            SettingCellModel(title: "Invite Friends", handler: { [weak self] in
                self?.inviteFriends()
            }),
            SettingCellModel(title: "Save Original Posts", handler: { [weak self] in
                self?.saveOriginalPosts()
            }),
        ])
        data.append([
            
            SettingCellModel(title: "Terms of Service", handler: { [weak self] in
                self?.openUrl(type: .terms)
            }),
            SettingCellModel(title: "Privacy Policy", handler: { [weak self] in
                self?.openUrl(type: .privacy)
            }),
            SettingCellModel(title: "Help / Feedback", handler: { [weak self] in
                self?.openUrl(type: .help)
            })
        ])
        
        data.append([
            SettingCellModel(title: "Log out", handler: { [weak self] in
                self?.handleSignout()
            })
        ])
    }
    enum SettingsURLType {
        case terms, privacy, help
    }
    private func openUrl(type: SettingsURLType) {
        let urlString: String
        switch type {
        case .terms:
            urlString = "https://help.instagram.com/581066165581870/?helpref=uf_share"
        case .privacy:
            urlString = "https://help.instagram.com/519522125107875/?helpref=uf_share"
        case .help:
            urlString = "https://help.instagram.com/"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    private func saveOriginalPosts() {
        
    }
    private func inviteFriends() {
        
    }
    private func editProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        present(navVc, animated: true)
    }
    func handleSignout() {
        let alert = UIAlertController(title: "Warning!!!", message: "Are you sure want to Sign out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Sign out", style: .destructive, handler: {[weak self] _ in
            AuthManager.shared.logOut { result in
                DispatchQueue.main.async {
                    if result {
                        self?.navigationController?.popToRootViewController(animated: true)
                        self?.tabBarController?.selectedIndex = 0
                    }
                    else {
                        fatalError("Could not log in user")
                    }
                }
                
            }
        }))
        alert.popoverPresentationController?.sourceView = tableview
        alert.popoverPresentationController?.sourceRect = tableview.bounds
        present(alert, animated: true)
        
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
}
