//
//  UserTableViewCell.swift
//  authSystemClient
//
//  Created by wankikim-MN on 2021/12/20.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    enum Constant {
        static let verticalInset: CGFloat = 5
        static let leadingInset: CGFloat = 20
        static let trailingInset: CGFloat = 10
    }
    static let reuseIdentifier = "\(UserTableViewCell.self)"
    
    private lazy var emailLabel: UILabel = { return UILabel(frame: .zero) }()
    private lazy var nameLabel: UILabel = { return UILabel(frame: .zero) }()
    private lazy var nicknameLabel: UILabel = { return UILabel(frame: .zero) }()
    private lazy var commentCountLabel: UILabel = { return UILabel(frame: .zero) }()
    
    private lazy var vStackView: UIStackView = { return UIStackView(frame: .zero) }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
}

// MARK: - ViewConfiguration
extension UserTableViewCell: ViewConfiguration {
    func buildHierarchy() {
        vStackView.addArrangedSubviews(emailLabel, nameLabel, nicknameLabel, commentCountLabel)
        contentView.addSubviews(vStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: Constant.verticalInset),
            vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                               constant: -Constant.verticalInset),
            vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                constant: Constant.leadingInset),
            vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                 constant: -Constant.trailingInset)
        ])
    }
    
    func configureViews() {
        self.backgroundColor = .clear
        self.accessoryType = .disclosureIndicator
        
        vStackView.axis = .vertical
        vStackView.alignment = .leading
        vStackView.distribution = .fillProportionally
        
        emailLabel.font = .preferredFont(forTextStyle: .title3)
        nameLabel.font = .preferredFont(forTextStyle: .body)
        nicknameLabel.font = .preferredFont(forTextStyle: .footnote)
        nicknameLabel.textColor = .darkGray
        commentCountLabel.font = .preferredFont(forTextStyle: .footnote)
    }
}

extension UserTableViewCell {
    func configure(_ user: PrivateInfo) {
        emailLabel.text = user.email
        nameLabel.text = user.name
        nicknameLabel.text = user.nickname
    }
}

