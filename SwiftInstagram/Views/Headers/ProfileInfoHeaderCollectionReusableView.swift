//
//  ProfileInfoHeaderCollectionReusableView.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 05/05/22.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderPostButtonClicked(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderFollowersButtonClicked(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderFollowingButtonClicked(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderEditProfileButtonClicked(_ header: ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileHeaderCollectionReusableView"
    weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    private let avatarImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "test")
        return imgView
    }()
    
    private let buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
    }()
    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        return button
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.separator.cgColor
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        return button
    }()
    
    private let nameLbl: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Rathakrishna"
        
        return label
    }()
    
    private let bioLbl: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Demo Insta profile \n #Nature lover"
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imgWidth = width/4
        avatarImageView.snp.makeConstraints { make in
            make.left.top.equalTo(5)
            make.width.height.equalTo(imgWidth)
        }
        avatarImageView.layer.cornerRadius = imgWidth/2
        avatarImageView.layer.masksToBounds = true
        
        
        buttonView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(imgWidth/2)
        }
       
        let buttonWidth = (buttonView.width/3)-5

        postsButton.snp.makeConstraints { make in
            make.left.top.height.equalToSuperview()
            make.width.equalTo(buttonWidth)
        }
        followersButton.snp.makeConstraints { make in
            make.left.equalTo(postsButton.snp.right).offset(5)
            make.top.height.equalToSuperview()
            make.width.equalTo(buttonWidth)
        }
        followingButton.snp.makeConstraints { make in
            make.left.equalTo(followersButton.snp.right).offset(5)
            make.top.height.equalToSuperview()
            make.width.equalTo(buttonWidth)
        }
        editProfileButton.snp.makeConstraints { make in
            make.left.right.equalTo(buttonView)
            make.top.equalTo(buttonView.snp.bottom).offset(5)
            make.height.equalTo(40)
        }
        
        nameLbl.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView)
            make.top.equalTo(avatarImageView.snp.bottom).offset(10)
        }
        bioLbl.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView)
            make.top.equalTo(nameLbl.snp.bottom).offset(10)
        }
    }
    
    private func addSubviews() {
        addSubview(avatarImageView)
        addSubview(buttonView)
        buttonView.addSubview(postsButton)
        buttonView.addSubview(followersButton)
        buttonView.addSubview(followingButton)
        addSubview(editProfileButton)
        addSubview(nameLbl)
        addSubview(bioLbl)
        addButtonActions()
    }
    
    func addButtonActions() {
        postsButton.addTarget(self, action: #selector(didTapPostBtn), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTapFollowerBtn), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingBtn), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileBtn), for: .touchUpInside)
    }
    
    @objc func didTapPostBtn() {
        delegate?.profileHeaderPostButtonClicked(self)
    }
    @objc func didTapFollowerBtn() {
        delegate?.profileHeaderFollowersButtonClicked(self)
    }
    @objc func didTapFollowingBtn() {
        delegate?.profileHeaderFollowingButtonClicked(self)
    }
    @objc func didTapEditProfileBtn() {
        delegate?.profileHeaderEditProfileButtonClicked(self)
    }
    
}
