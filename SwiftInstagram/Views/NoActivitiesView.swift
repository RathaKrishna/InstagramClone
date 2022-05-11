//
//  NoActivitiesView.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 10/05/22.
//

import UIKit

class NoActivitiesView: UIView {

    private let label: UILabel = {
        let label = UILabel()
        label.text = "No Notifications Yet"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    private let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.tintColor = .secondaryLabel
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(systemName: "bell")
        return imgView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(imgView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.snp.makeConstraints { make in
            make.height.width.equalTo(60)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }
    }
}
