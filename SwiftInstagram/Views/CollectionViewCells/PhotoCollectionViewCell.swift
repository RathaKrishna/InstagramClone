//
//  PhotoCollectionViewCell.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 05/05/22.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    
    private let postImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleToFill
        return imgView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(postImageView)
        contentView.clipsToBounds = true
        
        accessibilityLabel = "User post image"
        accessibilityHint = "Double-tap to open post"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with model: UserPostModel) {
        let thumnailImg  = model.thumbil
        postImageView.sd_setImage(with: thumnailImg, placeholderImage: UIImage(named: ""))
    }
    
    public func configure(imageName: String) {
        postImageView.image = UIImage(named: imageName)
    }
}
