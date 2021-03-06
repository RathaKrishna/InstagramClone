//
//  EditProfileViewController.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 29/04/22.
//

import UIKit
 
// Model
struct EditProfileModel {
    let label: String
    let placeholder: String
    var value: String?
}

final class EditProfileViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return tableView
    }()
    
    private let avatarButton: UIButton = {
        let avatarButton = UIButton()
        avatarButton.layer.masksToBounds = true
        avatarButton.tintColor = .label
        avatarButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        avatarButton.layer.borderWidth = 1
        avatarButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return avatarButton
    }()
    
    private var models = [[EditProfileModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureModels()
        setupNavBar()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        downloadAvatar()
        tableView.tableHeaderView = createTableHeaderView()
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didSaveButtonClicked))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didCancelButtonClicked))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
        
        
        header.addSubview(avatarButton)
        let size = header.height/2
       
        avatarButton.layer.cornerRadius = size/2.0
       
        avatarButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(size)
        }
        avatarButton.addTarget(self, action: #selector(didTapProfileImage), for: .touchUpInside)
        
        
        let lable = UIButton()
        header.addSubview(lable)
        lable.setTitle("Change profile photo", for: .normal)
        lable.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        lable.setTitleColor(.link, for: .normal)
        lable.titleLabel?.textAlignment = .center
        lable.addTarget(self, action: #selector(didTapProfileImage), for: .touchUpInside)
        
        lable.snp.makeConstraints { make in
            make.top.equalTo(avatarButton.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }
        
        return header
    }
    
    private func configureModels() {
        // Name username, website and bio
        let firstSectionLabels = ["Name","Username","Website","Bio"]
        var firstSection = [EditProfileModel]()
        for label in firstSectionLabels {
            let model = EditProfileModel(label: label, placeholder: "Enter \(label)...", value: nil)
            firstSection.append(model)
        }
        models.append(firstSection)
        //email, phone, gender
        let secondSectionLabels = ["Email","Phone","Gender"]
        var secondSection = [EditProfileModel]()
        for label in secondSectionLabels {
            let model = EditProfileModel(label: label, placeholder: "Enter \(label)...", value: nil)
            secondSection.append(model)
        }
        models.append(secondSection)
    }
    
    
    // MARK: - Button actions
    @objc func didTapProfileImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    @objc func didSaveButtonClicked() {
        
    }
    @objc func didCancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc private func didProfilePictureClicked() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change profile picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        present(actionSheet, animated: true)
    }
    
    private func downloadAvatar() {
        StorageManager.shared.downloadImage(with: "images/avatar.png") {[weak self] imgResult in
            DispatchQueue.main.async {
                
                switch imgResult {
                case .success(let url):
                    print("result url is \(url)")
                    self?.avatarButton.sd_setImage(with: url, for: .normal)
                case .failure(let imgError):
                    print(imgError.localizedDescription)
                }
                
            }
        }
    }
}

// MARK: - TableView Delegate
extension EditProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else{
            return nil
        }
        return "Personal Information"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as? FormTableViewCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.section][indexPath.row]
        cell.delegate = self
        cell.configure(with: model)
        
        return cell
    }
   
    

    
}
// MARK: - TableViewCell Delegate
extension EditProfileViewController: FormTableViewCellDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileModel) {
        print("field upated \(updatedModel.value ?? "")")
    }
    
    
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        guard let imgData = image.pngData() else {
            return
        }
        // Upload image data
        StorageManager.shared.uploadImage(imageData: imgData) {[weak self] result in
            switch result {
            case .success(let successResult):
                self?.downloadAvatar()
            case .failure(let failedResult):
                print(failedResult.localizedDescription)
            }
        }
        // get download url
        // save download url
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
