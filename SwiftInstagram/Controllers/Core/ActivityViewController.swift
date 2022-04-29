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
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Activity"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

extension ActivityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
