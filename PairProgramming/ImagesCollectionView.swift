//
//  ImagesCollectionView.swift
//  PairProgramming
//
//  Created by Andreas Binnewies on 2/3/21.
//

import Foundation
import UIKit

class ImagesCollectionView: UICollectionView {
  var selectImage: ((URL)->Void)? = nil

  private let numberOfColumns = 3
  private let interItemSpacing: CGFloat = 1

  private let imageURLs = [
    URL(string: "https://cdn.pixabay.com/photo/2017/02/20/18/03/cat-2083492_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2018/02/21/05/17/cat-3169476_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2017/03/14/14/49/cat-2143332_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2018/01/28/12/37/cat-3113513_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2014/05/07/06/44/cat-339400_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2016/06/14/00/14/cat-1455468_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2013/04/01/03/45/cat-98359_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2017/07/24/19/57/tiger-2535888_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2019/11/08/11/56/cat-4611189_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2016/09/05/21/37/cat-1647775_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2016/02/10/16/37/cat-1192026_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2014/03/29/09/17/cat-300572_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2017/11/09/21/41/cat-2934720_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2017/11/14/13/06/kitty-2948404_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2016/07/10/21/47/cat-1508613_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2017/07/25/01/22/cat-2536662_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2015/11/16/14/43/cat-1045782_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2014/04/13/20/49/cat-323262_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2013/05/30/18/21/cat-114782_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2015/03/27/13/16/cat-694730_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2015/11/16/22/14/cat-1046544_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2019/05/08/21/21/cat-4189697_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2016/03/28/10/05/kitten-1285341_1280.jpg")!,
    URL(string: "https://cdn.pixabay.com/photo/2012/11/26/13/58/cat-67345_1280.jpg"),
  ]

  init() {
    super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    delegate = self
    dataSource = self
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ImagesCollectionView: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }

  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    imageURLs.count
  }

  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
    cell.setImageURL(to: imageURLs[indexPath.row])
    return cell
  }
}

extension ImagesCollectionView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectImage?(imageURLs[indexPath.row])
  }
}

extension ImagesCollectionView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let widthMinusSpacing = bounds.width
    let itemDimension = floor(widthMinusSpacing / CGFloat(numberOfColumns))
    return CGSize(width: itemDimension, height: itemDimension)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    interItemSpacing
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    interItemSpacing
  }
}
