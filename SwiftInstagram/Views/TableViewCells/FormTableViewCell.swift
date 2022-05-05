//
//  FormTableViewCell.swift
//  SwiftInstagram
//
//  Created by Rathakrishnan Ramasamy on 05/05/22.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileModel)
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
    static let identifier = "FormTableViewCell"
    public weak var delegate: FormTableViewCellDelegate?
    
    private var model: EditProfileModel?
    
    private let formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        selectionStyle = .none
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        field.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        formLabel.snp.makeConstraints { make in
            make.left.top.equalTo(15)
            make.right.equalToSuperview().offset(-15)
        }
        field.snp.makeConstraints { make in
            make.left.right.equalTo(formLabel)
            make.top.equalTo(formLabel.snp.bottom).offset(10)
        }

        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    public func configure(with model: EditProfileModel) {
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    
    // MARK: - UITextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        model?.value = textField.text
        guard let model = model else {
             return true
        }
        
        delegate?.formTableViewCell(self, didUpdateField: model)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        model?.value = textField.text
        guard let model = model else {
             return 
        }
        
        delegate?.formTableViewCell(self, didUpdateField: model)
    }
}
