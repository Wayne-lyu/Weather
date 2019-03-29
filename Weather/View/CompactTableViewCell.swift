//
//  CompactTableViewCell.swift
//  Weather
//
//  Created by wayne.lv on 2019/3/29.
//

import UIKit

class CompactTableViewCell: UITableViewCell {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }

    lazy var iconImage: UIImageView = {

        let iconImage = UIImageView()
        contentView.addSubview(iconImage)

        return iconImage
    } ()

    lazy var titleLabel: UILabel = {

        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: FontSize.L)
        titleLabel.textColor = UIColor.black
        contentView.addSubview(titleLabel)

        return titleLabel
    } ()

    lazy var subTitleLabel: UILabel = {

        let subTitleLabel = UILabel()
        subTitleLabel.font = UIFont.systemFont(ofSize: FontSize.S)
        subTitleLabel.textColor = UIColor.gray
        contentView.addSubview(subTitleLabel)

        return subTitleLabel
    } ()

    static let ImageWith: CGFloat = 60
    static let ImageHeight: CGFloat = 60
    static let CellHeight: CGFloat = 100

    private func setupUI() {

        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                           constant: Margin.S).isActive = true
        iconImage.topAnchor.constraint(equalTo: contentView.topAnchor,
                                       constant: Margin.M).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: CompactTableViewCell.ImageWith).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: CompactTableViewCell.ImageHeight).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                            constant: CompactTableViewCell.ImageWith + Margin.M).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                             constant: Margin.M).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                        constant: Margin.M).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor,
                                           constant: -Margin.S).isActive = true

        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: CompactTableViewCell.ImageWith + Margin.M).isActive = true
        subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: Margin.M).isActive = true
        subTitleLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor,
                                           constant: Margin.S).isActive = true
        subTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: -Margin.M).isActive = true

        self.contentView.heightAnchor.constraint(equalToConstant: CompactTableViewCell.CellHeight).isActive = true
        self.backgroundColor = .white
        self.selectionStyle = .none
    }
}
