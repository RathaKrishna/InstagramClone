//
//  ActivityLikeEventTableViewCell.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 10/05/22.
//

import UIKit

protocol ActivityLikeEventTableViewCellDelegate: AnyObject {
    func didTapLikeButton(model: String)
}

class ActivityLikeEventTableViewCell: UITableViewCell {

    static let identifier = "ActivityLikeEventTableViewCell"
    weak var delegate: ActivityLikeEventTableViewCellDelegate?
    
    private var model: UserActivity?
    
    private let profileImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImgView)
        contentView.addSubview(label)
        contentView.addSubview(likeButton)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImgView.image = nil
        label.text = nil
        likeButton.setTitle(nil, for: .normal)
        likeButton.backgroundColor = nil
        likeButton.layer.borderWidth = 0
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    public func configure(with model: UserActivity){
        self.model = model
        switch model.type {
        case .like: break
        case .follow: break
        }
        label.text = model.text
        profileImgView.sd_setImage(with: model.user.profilePic)
    }
}
