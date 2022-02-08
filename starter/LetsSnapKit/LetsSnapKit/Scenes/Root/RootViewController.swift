//
//  RootViewController.swift
//  LetsSnapKit
//
//  Created by Aaron Lee on 2022/02/08.
//

import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

private let menuCollectionViewCellIdentifier = "menuCollectionViewCellIdentifier"

class RootViewController: ViewController {
  var menuCollectionView: UICollectionView!

  var menuCollectionViewFlowLayout = UICollectionViewFlowLayout()

  var scrollView = UIScrollView()

  var contentView = UIView()

  var loremStackView = UIStackView()

  var menu = Menu.allCases

  override func viewDidLoad() {
    super.viewDidLoad()

    configureView()
    layoutView()

    view.backgroundColor = .white

    // TODO: Select first item
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    // TODO: Update layout
  }
}

// MARK: - Configure

extension RootViewController {
  private func configureView() {
    // TODO: Configure Views
  }
}

// MARK: - Layout

extension RootViewController {
  private func layoutView() {
    // TODO: Layout Views
  }
}

// TODO: DataSource & Delegate
