//
//  ImageCache.swift
//  PairProgramming
//
//  Created by Andreas Binnewies on 2/3/21.
//

import Foundation
import UIKit

struct ImageInfo {
  let image: UIImage
  let fileFormat = "JPEG"
  let fileSize: Int
}

class ImageCache {
  static let shared = ImageCache()

  private var cachedImageInfo: [URL: ImageInfo] = [:]

  func loadImage(from url: URL,
                 completion: @escaping (ImageInfo) -> Void) {
    if let imageInfo = cachedImageInfo[url] {
      completion(imageInfo)
      return
    }
  }
}
