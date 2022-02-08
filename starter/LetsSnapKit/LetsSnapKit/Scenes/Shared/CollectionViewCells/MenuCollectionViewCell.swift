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

  var label = UILabel()

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
    // TODO: Prepare for reuse
  }

  override var isSelected: Bool {
    didSet {
      // TODO: Toggle Selected
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
    // TODO: Configure Cell
  }
}

// MARK: - Layout

extension MenuCollectionViewCell {
  private func layoutView() {
    // TODO: Layout Cell
  }
}
