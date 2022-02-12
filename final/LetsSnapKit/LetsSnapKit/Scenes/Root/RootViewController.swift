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
  var bag = DisposeBag()

  var offset: [IndexPath: CGFloat] = [:]

  var menuCollectionView: UICollectionView!

  var menuCollectionViewFlowLayout = UICollectionViewFlowLayout()
    .then {
      $0.scrollDirection = .horizontal
    }

  var scrollView = UIScrollView()
    .then {
      $0.isDirectionalLockEnabled = true
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

    scrollView
      .rx
      .didScroll
      .withUnretained(self)
      .observe(on: MainScheduler.asyncInstance)
      .bind(onNext: { owner, _ in

        if !owner.scrollView.isDragging, !owner.scrollView.isDecelerating { return }

        guard let currentIndex = owner.menuCollectionView.indexPathsForSelectedItems?.first else {
          return
        }

        let width = owner.scrollView.frame.width

        let newX = width * CGFloat(currentIndex.item)
        owner.scrollView.contentOffset.x = newX

      })
      .disposed(by: bag)
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
        $0.width.equalTo(view.safeAreaLayoutGuide)
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
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    offset[indexPath] = scrollView.contentOffset.y
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let newX = scrollView.frame.width * CGFloat(indexPath.item)

    guard !newX.isNaN, !newX.isInfinite else { return }

    let newPoint = CGPoint(x: newX,
                           y: scrollView.contentOffset.y)

    DispatchQueue.main.async {
      UIView.animate(withDuration: 0.2) {
        self.scrollView.setContentOffset(newPoint, animated: false)
      } completion: { [weak self] _ in
        guard let self = self else { return }

        if let offset = self.offset[indexPath] {
          self.scrollView.contentOffset.y = offset
        } else {
          self.scrollView.contentOffset.y = .zero
        }
      }
    }
  }
}
