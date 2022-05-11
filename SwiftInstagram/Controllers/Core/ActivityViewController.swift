//
//  ActivityViewController.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 26/04/22.
//

import UIKit

class ActivityViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        
        table.register(ActivityLikeEventTableViewCell.self, forCellReuseIdentifier: ActivityLikeEventTableViewCell.identifier)
        table.register(ActivityFollowEventTableViewCell.self, forCellReuseIdentifier: ActivityFollowEventTableViewCell.identifier)
        table.isHidden = true
        return table
    }()
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    private lazy var noActivityView = NoActivitiesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Activity"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(spinner)
//        spinner.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.center.equalToSuperview()
        }
    }
    private func layoutNoActivitiyView() {
        tableView.isHidden = true
        view.addSubview(noActivityView)
        noActivityView.frame = view.bounds
    }

}

// MARK: - Tableview 

extension ActivityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
