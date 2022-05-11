//
//  ActivityFollowEventTableViewCell.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 10/05/22.
//

import UIKit

protocol ActivityFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowButton(model: String)
}

class ActivityFollowEventTableViewCell: UITableViewCell {

    static let identifier = "ActivityFollowEventTableViewCell"
    weak var delegate: ActivityFollowEventTableViewCellDelegate?
    
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
    
    private let followButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImgView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImgView.image = nil
        label.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    public func configure(with model: UserActivity){
        
    }
}
