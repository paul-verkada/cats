//
//  ImageCell.swift
//  PairProgramming
//
//  Created by Andreas Binnewies on 2/3/21.
//

import Foundation
import TinyConstraints
import UIKit

class ImageCell: UICollectionViewCell {
  private let imageView = UIImageView()
  private let selectedOverlay = UIView()

  override var isSelected: Bool {
    didSet {
      selectedOverlay.isHidden = !isSelected
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    imageView.contentMode = .scaleAspectFill
    addSubview(imageView)
    imageView.edgesToSuperview()

    addSubview(selectedOverlay)
    selectedOverlay.edgesToSuperview()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    imageView.image = nil
    selectedOverlay.isHidden = true
  }

  func setImageURL(to imageURL: URL) {
    ImageCache.shared.loadImage(from: imageURL) { imageInfo in
      self.imageView.image = imageInfo.image
    }
  }
}
