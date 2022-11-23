//
//  ShadowButton.swift
//  PairProgramming
//
//  Created by Andreas Binnewies on 2/3/21.
//

import Foundation
import UIKit

class ShadowButton: UIButton {
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    addDropShadow()
  }

  private func addDropShadow() {
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowRadius = 2
    layer.shadowOffset = CGSize(width: 1, height: 1)
    layer.shadowOpacity = 0.5
  }
}
