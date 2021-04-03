//
//  DefectCell.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/8/21.
//

import UIKit

class DefectCell: UITableViewCell {
    
    var defect: Defect! {
        didSet{
            configureViews()
        }
    }
    
    let completedIndicator = UIImageView()
    
    let headingLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    let defectDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    let chevron: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .systemGray4
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        addSubviews()
        setupSubviews()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCompletedIndicator() {
        if defect.resolved {
            imageView!.image = UIImage(systemName: "checkmark.circle")!
            imageView!.tintColor = .systemGreen
        } else {
            imageView!.image = UIImage(systemName: "xmark.circle")!
            imageView!.tintColor = .systemRed
        }
    }
    
    func configureViews() {
        headingLabel.text = "\(defect.sta) - \(defect.ac) - \(defect.ata4.prefix(4)) - \(defect.id)"
        defectDescriptionLabel.text = defect.description
        setCompletedIndicator()
    }
    
    func addSubviews() {
        contentView.addSubview(headingLabel)
        contentView.addSubview(defectDescriptionLabel)
        contentView.addSubview(chevron)
    }
    
    func setupSubviews() {
        chevron.anchor(
            right: contentView.rightAnchor,
            centerY: contentView.centerYAnchor,
            paddingRight: .padding,
            width: 11,
            height: 17
        )
        
        imageView!.anchor(
            left: contentView.leftAnchor,
            centerY: contentView.centerYAnchor,
            paddingLeft: .padding,
            width: 26,
            height: 26
        )
        
        headingLabel.anchor(
            top: contentView.topAnchor,
            left: imageView!.rightAnchor,
            right: chevron.leftAnchor,
            paddingTop: .halfPadding,
            paddingLeft: .padding,
            paddingRight: .halfPadding
        )
        
        defectDescriptionLabel.anchor(
            top: headingLabel.bottomAnchor,
            left: imageView!.rightAnchor,
            bottom: contentView.bottomAnchor,
            right: chevron.leftAnchor,
            paddingTop: .halfPadding,
            paddingLeft: .padding,
            paddingBottom: .halfPadding,
            paddingRight: .halfPadding
        )
    }
    
}
