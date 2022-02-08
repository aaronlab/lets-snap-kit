//
//  LoremView.swift
//  LetsSnapKit
//
//  Created by Aaron Lee on 2022/02/08.
//

import SnapKit
import Then
import UIKit

class LoremView: UIView {
  var stackView = UIStackView()

  var titleLabel = UILabel()

  var imageView = UIImageView(image: UIImage(named: "image"))

  var contentLabel = UITextView()

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
}

// MARK: - Helpers

extension LoremView {
  func configureView(with lorem: Lorem) {
    titleLabel.text = lorem.title
    contentLabel.text = lorem.contents
  }
}

// MARK: - Configure

extension LoremView {
  private func configureView() {
    // TODO: Configure Lorem View
  }
}

// MARK: - Layout

extension LoremView {
  private func layoutView() {
    // MARK: - Layout Lorem View
  }
}
