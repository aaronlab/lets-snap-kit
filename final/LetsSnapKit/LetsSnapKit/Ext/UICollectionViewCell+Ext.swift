//
//  UICollectionViewCell+Ext.swift
//  LetsSnapKit
//
//  Created by Aaron Lee on 2022/02/08.
//

import UIKit

extension UICollectionViewCell {
  func flowLayoutAttr(with layoutAttributes: UICollectionViewLayoutAttributes)
    -> UICollectionViewLayoutAttributes {
    setNeedsLayout()
    layoutIfNeeded()
    let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
    var frame = layoutAttributes.frame
    frame.size.width = ceil(size.width)
    layoutAttributes.frame = frame
    return layoutAttributes
  }
}
