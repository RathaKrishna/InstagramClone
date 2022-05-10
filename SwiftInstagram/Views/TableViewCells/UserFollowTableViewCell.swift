//
//  UserFollowTableViewCell.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 09/05/22.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didFollowUnFollowClicked(model: UserFollowViewModel)
}

enum FollowState {
    case following, not_following
}

struct UserFollowViewModel {
    let username: String
    let name: String
    let type: FollowState
}
class UserFollowTableViewCell: UITableViewCell {
    static let identifier = "UserFollowTableViewCell"
    weak var delegate: UserFollowTableViewCellDelegate?
    
    private let profileImgView: UIImageView = {
        let imgV = UIImageView()
        imgV.layer.masksToBounds = true
        imgV.backgroundColor = .secondarySystemBackground
        imgV.contentMode = .scaleAspectFill
        return imgV
    }()
    
    private let nameLable: UILabel = {
        let lable = UILabel()
        lable.text = "Jhon"
        lable.textColor = .label
        lable.font = .systemFont(ofSize: 17, weight: .semibold)
        return lable
    }()
    
    private let usernameLable: UILabel = {
        let lable = UILabel()
        lable.text = "@jhon"
        lable.textColor = .secondaryLabel
        lable.font = .systemFont(ofSize: 16, weight: .regular)
        return lable
    }()
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Follow", for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        addSubview(profileImgView)
        addSubview(nameLable)
        addSubview(usernameLable)
        addSubview(followButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImgView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(3)
            make.width.height.equalTo(contentView.height-6)
        }
        profileImgView.layer.cornerRadius = (contentView.height-6)/2
        
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width/3
        
        followButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(buttonWidth)
            make.height.equalTo(44)
            make.centerY.equalToSuperview()
        }
        
        nameLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(profileImgView.snp.right).offset(10)
            make.right.equalTo(followButton.snp.left).offset(-10)
//            make.height.equalTo(contentView.height/2)
            
        }
        usernameLable.snp.makeConstraints { make in
            make.top.equalTo(nameLable.snp.bottom).offset(5)
            make.left.equalTo(profileImgView.snp.right).offset(10)
            make.right.equalTo(followButton.snp.left).offset(-10)
//            make.height.equalTo(contentView.height/2)
            
        }
         
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImgView.image = nil
        nameLable.text = nil
        usernameLable.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
    }

    public func configure(with model: UserFollowViewModel) {
        nameLable.text = model.name
        usernameLable.text = model.username
        switch model.type {
        case .following:
            followButton.setTitle("UnFollow", for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.setTitleColor(.label, for: .normal)
            followButton.layer.borderColor = UIColor.separator.cgColor
            followButton.layer.borderWidth = 1
            
        case .not_following:
            followButton.setTitle("Follow", for: .normal)
            followButton.backgroundColor = .systemBlue
            followButton.setTitleColor(.white, for: .normal)
            followButton.layer.borderWidth = 0
            
        }
    }
}
