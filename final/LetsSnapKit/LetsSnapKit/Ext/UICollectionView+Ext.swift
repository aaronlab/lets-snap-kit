//
//  UICollectionView+Ext.swift
//  LetsSnapKit
//
//  Created by Aaron Lee on 2022/02/08.
//

import UIKit

extension UICollectionView {
  convenience init(collectionViewLayout: UICollectionViewLayout,
                   backgroundColor: UIColor? = .clear,
                   contentInsetAdjustmentBehavior: UIScrollView
                     .ContentInsetAdjustmentBehavior = .never) {
    self.init(frame: .zero, collectionViewLayout: collectionViewLayout)
    self.backgroundColor = backgroundColor
    self.contentInsetAdjustmentBehavior = contentInsetAdjustmentBehavior
  }
}
