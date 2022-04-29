//
//  EditProfileViewController.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 29/04/22.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didSaveButtonClicked))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didCancelButtonClicked))
    }

    @objc func didSaveButtonClicked() {
        
    }
    @objc func didCancelButtonClicked() {
        
    }
    
    @objc private func didProfilePictureClicked() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change profile picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet, animated: true)
    }
}
