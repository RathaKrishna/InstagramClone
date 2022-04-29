//
//  PostHeaderTableViewCell.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 29/04/22.
//

import UIKit

class PostHeaderTableViewCell: UITableViewCell {

    static let identifier = "PostHeaderTableViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func prepareForReuse() {
        
    }
    public func configure() {
        // configure cell with model
    }
}
