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
    .then {
      $0.axis = .vertical
      $0.alignment = .fill
      $0.distribution = .fill
      $0.spacing = 16.0
    }

  var titleLabel = UILabel()
    .then {
      $0.font = .boldSystemFont(ofSize: 18)
    }

  var imageView = UIImageView(image: UIImage(named: "image"))
    .then {
      $0.clipsToBounds = true
      $0.contentMode = .scaleToFill
    }

  var contentTextview = UITextView()
    .then {
      $0.isEditable = false
      $0.isScrollEnabled = false
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
}

// MARK: - Helpers

extension LoremView {
  func configureView(with lorem: Lorem) {
    titleLabel.text = lorem.title
    contentTextview.text = lorem.contents
  }
}

// MARK: - Configure

extension LoremView {
  private func configureView() {
    addSubview(stackView)
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(contentTextview)
    stackView.addArrangedSubview(imageView)
  }
}

// MARK: - Layout

extension LoremView {
  private func layoutView() {
    layoutStackView()
    layoutImageView()
  }

  private func layoutStackView() {
    stackView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().offset(16)
      $0.bottom.trailing.equalToSuperview().offset(-16)
    }
  }

  private func layoutImageView() {
    imageView.snp.makeConstraints {
      $0.height.equalTo(imageView.snp.width)
    }
  }
}
