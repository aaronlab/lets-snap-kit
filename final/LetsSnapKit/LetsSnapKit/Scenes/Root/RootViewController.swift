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
    .then {
      $0.scrollDirection = .horizontal
    }

  var scrollView = UIScrollView()
    .then {
      $0.isScrollEnabled = false
      $0.showsVerticalScrollIndicator = false
      $0.showsHorizontalScrollIndicator = false
    }

  var contentView = UIView()

  var loremStackView = UIStackView()
    .then {
      $0.axis = .horizontal
      $0.alignment = .fill
      $0.distribution = .fill
      $0.spacing = .zero
    }

  var menu = Menu.allCases

  override func viewDidLoad() {
    super.viewDidLoad()

    configureView()
    layoutView()

    view.backgroundColor = .white

    menuCollectionView?.selectItem(at: IndexPath(item: .zero, section: .zero),
                                   animated: false,
                                   scrollPosition: [])
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    menuCollectionViewFlowLayout.invalidateLayout()
  }
}

// MARK: - Configure

extension RootViewController {
  private func configureView() {
    configureMenuCollectionView()
    addSubViews()
    addLoremViews()
  }

  private func configureMenuCollectionView() {
    menuCollectionView = UICollectionView(collectionViewLayout: menuCollectionViewFlowLayout)
    menuCollectionView.showsVerticalScrollIndicator = false
    menuCollectionView.showsHorizontalScrollIndicator = false
    menuCollectionView.isPagingEnabled = true

    menuCollectionView.register(MenuCollectionViewCell.self,
                                forCellWithReuseIdentifier: menuCollectionViewCellIdentifier)

    menuCollectionView.dataSource = self
    menuCollectionView.delegate = self
    menuCollectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

    view.addSubview(menuCollectionView)
  }

  private func addSubViews() {
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addSubview(loremStackView)
  }

  private func addLoremViews() {
    menu.forEach { _ in
      let loremView = LoremView()
      loremView.configureView(with: Lorem())
      loremStackView.addArrangedSubview(loremView)

      loremView.snp.makeConstraints {
        $0.width.equalTo(scrollView)
      }
    }
  }
}

// MARK: - Layout

extension RootViewController {
  private func layoutView() {
    layoutMenuCollectionView()
    layoutScrollView()
  }

  private func layoutMenuCollectionView() {
    menuCollectionView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      $0.height.equalTo(52)
    }
  }

  private func layoutScrollView() {
    scrollView.snp.makeConstraints {
      $0.top.equalTo(menuCollectionView.snp.bottom)
      $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
    }

    contentView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.height.equalToSuperview()
    }

    loremStackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

// MARK: - UICollectionViewDataSource

extension RootViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    menu.count
  }

  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: menuCollectionViewCellIdentifier,
      for: indexPath
    ) as? MenuCollectionViewCell else {
      return UICollectionViewCell()
    }

    let menu = menu[indexPath.item]

    cell.configureCell(with: menu)

    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RootViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    .zero
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    .zero
  }
}

// MARK: - UICollectionViewDelegate

extension RootViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let newX = scrollView.frame.width * CGFloat(indexPath.item)

    guard !newX.isNaN, !newX.isInfinite else { return }

    let newPoint = CGPoint(x: newX,
                           y: scrollView.contentOffset.y)

    DispatchQueue.main.async {
      self.scrollView.setContentOffset(newPoint, animated: true)
    }
  }
}
