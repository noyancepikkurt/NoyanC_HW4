//
//  CustomTextField.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit

final class CustomTextField: UITextField {
    
    let placeholderInsets = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 10)
    
    lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .systemGray3
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        self.placeholder = "Artist, Songs, Album"
        self.backgroundColor = .white
        self.attributedPlaceholder = NSAttributedString(string: "Artist, Song, Album", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.italicSystemFont(ofSize: 14)
        ])
        self.textColor = .black
        self.font = UIFont.italicSystemFont(ofSize: 16)
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.systemGray3.cgColor
        addSubview()
        setupConstraints()
    }
    
    func setLightBlackBackgroundColor() {
           self.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
       }
    
    private func addSubview() {
        self.addSubview(leftImageView)
    }
    
    private func setupConstraints() {
        leftImageViewConstraints()
    }
    
    private func leftImageViewConstraints() {
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            leftImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            leftImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            leftImageView.widthAnchor.constraint(equalTo: leftImageView.heightAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.05
        self.layer.shadowRadius = 4
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 8).cgPath
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: placeholderInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: placeholderInsets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.placeholderRect(forBounds: bounds)
        return rect
    }
}
