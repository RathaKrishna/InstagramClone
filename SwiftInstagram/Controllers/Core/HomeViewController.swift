//
//  HomeViewController.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 26/04/22.
//

import FirebaseAuth
import FirebaseDatabase
import UIKit

class HomeViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FeedsPostTableViewCell.self, forCellReuseIdentifier: FeedsPostTableViewCell.identifier)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleAuthendication()
    }
    
    private func handleAuthendication() {
        // Check Login status
        if Auth.auth().currentUser == nil {
            // Show login
            let loginVc = LoginViewController()
            loginVc.modalPresentationStyle = .fullScreen
            present(loginVc, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: FeedsPostTableViewCell.identifier, for: indexPath) as! FeedsPostTableViewCell
        return cell
    }
}
