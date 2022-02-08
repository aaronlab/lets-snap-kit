//
//  Menu.swift
//  LetsSnapKit
//
//  Created by Aaron Lee on 2022/02/08.
//

import Foundation

enum Menu: String, CaseIterable {
  case first
  case second
  case third
  case fourth
  case fifth
  case sixth
  case seventh
  case eighth
  case nineth
  case tenth
}

extension Menu: CustomStringConvertible {
  var description: String {
    rawValue.capitalized
  }
}
