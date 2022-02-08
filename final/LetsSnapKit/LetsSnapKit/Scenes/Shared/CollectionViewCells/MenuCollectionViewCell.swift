//
//  MenuCollectionViewCell.swift
//  LetsSnapKit
//
//  Created by Aaron Lee on 2022/02/08.
//

import SnapKit
import Then
import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
  var containerView = UIView()
    .then {
      $0.clipsToBounds = true
      $0.layer.cornerRadius = 8.0
      $0.backgroundColor = .gray
    }

  var label = UILabel()
    .then {
      $0.font = .boldSystemFont(ofSize: 18)
      $0.textAlignment = .center
      $0.textColor = .white
    }

  // MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureView()
    layoutView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configureView()
    layoutView()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    label.text = nil
    configureSelected()
  }

  override var isSelected: Bool {
    didSet {
      configureSelected()
    }
  }

  private func configureSelected() {
    if isSelected {
      containerView.backgroundColor = .black
      return
    }

    containerView.backgroundColor = .gray
  }

  override func preferredLayoutAttributesFitting(
    _ layoutAttributes: UICollectionViewLayoutAttributes
  )
    -> UICollectionViewLayoutAttributes {
    flowLayoutAttr(with: layoutAttributes)
  }
}

// MARK: - Helpers

extension MenuCollectionViewCell {
  func configureCell(with menu: Menu) {
    label.text = menu.description
  }
}

// MARK: - Configure

extension MenuCollectionViewCell {
  private func configureView() {
    contentView.addSubview(containerView)
    containerView.addSubview(label)
  }
}

// MARK: - Layout

extension MenuCollectionViewCell {
  private func layoutView() {
    layoutContainerView()
    layoutLabel()
  }

  private func layoutContainerView() {
    containerView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().offset(8)
      $0.bottom.trailing.equalToSuperview().offset(-8)
    }
  }

  private func layoutLabel() {
    label.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
    }
  }
}
