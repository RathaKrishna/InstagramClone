//
//  ProfileTabsCollectionReusableView.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 05/05/22.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDeleagte: AnyObject {
    func didTapGridbutton()
    func didTapTaggedButton()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    weak var delegate: ProfileTabsCollectionReusableViewDeleagte?
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .label
        button.setImage(UIImage(systemName: "squareshape.split.3x3"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .secondaryLabel
        button.setImage(UIImage(systemName: "person.crop.rectangle"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(gridButton)
        addSubview(taggedButton)
        gridButton.addTarget(self, action: #selector(gridBtnClicked), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(taggedBtnClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gridButton.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(2)
            make.width.equalTo(width/2)
            make.height.equalTo(height-4)
        }
        taggedButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.left.equalTo(gridButton.snp.right)
            make.width.equalTo(width/2)
            make.height.equalTo(height-4)
        }
        
        gridButton.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        taggedButton.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)

    }
    
    @objc private func gridBtnClicked() {
        gridButton.tintColor = .label
        taggedButton.tintColor = .secondaryLabel
        delegate?.didTapGridbutton()
    }
    
    @objc private func taggedBtnClicked() {
        gridButton.tintColor = .secondaryLabel
        taggedButton.tintColor = .label
        delegate?.didTapTaggedButton()
    }
}
