//
//  ViewController.swift
//  PairProgramming
//
//  Created by Andreas Binnewies on 2/3/21.
//

import TinyConstraints
import UIKit

class ViewController: UIViewController {
  private let imagesCollectionView = ImagesCollectionView()

  private let imageView = UIImageView()
  private var imageViewTopConstraint: Constraint!
  private var topContainerHeightConstraint: Constraint!
  private let imageInfoButton = UIButton()
  private let imageDimensionsLabel = UILabel()
  private let imageFormatLabel = UILabel()
  private let imageSizeLabel = UILabel()

  private var isDisplayingImageInfo = false

  override func viewDidLoad() {
    super.viewDidLoad()

    imagesCollectionView.selectImage = handleImageSelected

    let topContainer = UIView()
    topContainer.backgroundColor = .black
    view.addSubview(topContainer)
    topContainer.edgesToSuperview(excluding: .bottom)
    topContainerHeightConstraint = topContainer.height(0)

    let imageInfoStackView = UIStackView()
    imageInfoStackView.spacing = 5
    topContainer.addSubview(imageInfoStackView)
    imageInfoStackView.centerInSuperview()

    let dimensionsTitleLabel = UILabel()
    dimensionsTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
    dimensionsTitleLabel.text = "Dimensions"
    dimensionsTitleLabel.textColor = .white
    dimensionsTitleLabel.textAlignment = .center
    imageInfoStackView.addArrangedSubview(dimensionsTitleLabel)
    imageDimensionsLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    imageDimensionsLabel.textColor = .white
    imageDimensionsLabel.textAlignment = .center
    imageInfoStackView.addArrangedSubview(imageDimensionsLabel)
    imageInfoStackView.setCustomSpacing(20, after: imageDimensionsLabel)

    let imageFormatTitleLabel = UILabel()
    imageFormatTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
    imageFormatTitleLabel.text = "Format"
    imageFormatTitleLabel.textColor = .white
    imageFormatTitleLabel.textAlignment = .center
    imageInfoStackView.addArrangedSubview(imageFormatTitleLabel)
    imageFormatLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    imageFormatLabel.textAlignment = .center
    imageInfoStackView.addArrangedSubview(imageFormatLabel)
    imageInfoStackView.setCustomSpacing(20, after: imageFormatLabel)

    let imageSizeTitleLabel = UILabel()
    imageSizeTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
    imageSizeTitleLabel.text = "Size"
    imageSizeTitleLabel.textColor = .white
    imageSizeTitleLabel.textAlignment = .center
    imageInfoStackView.addArrangedSubview(imageSizeTitleLabel)
    imageSizeLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    imageSizeLabel.textColor = .white
    imageSizeLabel.textAlignment = .center
    imageInfoStackView.addArrangedSubview(imageSizeLabel)

    imageView.contentMode = .scaleAspectFill
    topContainer.addSubview(imageView)
    imageView.horizontalToSuperview()
    imageView.heightToSuperview()
    imageViewTopConstraint = imageView.topToSuperview()

    view.addSubview(imagesCollectionView)
    imagesCollectionView.edgesToSuperview(excluding: .top)
    imagesCollectionView.topToBottom(of: topContainer, offset: 1)

    imageInfoButton.setImage(UIImage(named: "icon-info")!, for: .normal)
    topContainer.addSubview(imageInfoButton)
    imageInfoButton.leadingToSuperview(offset: 10)
    imageInfoButton.bottomToSuperview(offset: -10)

    let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                      action: #selector(handleImageContainerTap))
    topContainer.addGestureRecognizer(tapGestureRecognizer)
  }

  private func handleImageSelected(_ imageURL: URL) {
    expandTopImage()
    ImageCache.shared.loadImage(from: imageURL) { imageInfo in
      self.updateImageInfoLabels(from: imageInfo)
    }
  }

  private func updateImageInfoLabels(from imageInfo: ImageInfo) {
    let image = imageInfo.image
    imageDimensionsLabel.text = "\(Int(image.size.width))x\(Int(image.size.height))"
    imageFormatLabel.text = imageInfo.fileFormat

    if imageInfo.fileSize < 1000000 {
      let kilobytes = Int(ceil(Double(imageInfo.fileSize) / 1000))
      imageSizeLabel.text = "\(kilobytes)kB"
    } else {
      let megabytes = Int(ceil(Double(imageInfo.fileSize) / 1000000))
      imageSizeLabel.text = "\(megabytes)MB"
    }
  }

  private func expandTopImage() {
    if isDisplayingImageInfo {
      hideImageInfo()
    }
    
    topContainerHeightConstraint.constant = view.bounds.width * 3 / 4
    UIView.animate(withDuration: 0.3,
                   delay: 0,
                   usingSpringWithDamping: 0.6,
                   initialSpringVelocity: 1,
                   options: [.curveEaseOut],
                   animations: {
                    self.view.layoutIfNeeded()
                   },
                   completion: nil)
  }

  private func hideImageInfo() {
    isDisplayingImageInfo = false

    imageViewTopConstraint.constant = 0
    UIView.animate(withDuration: 0.3,
                   delay: 0,
                   usingSpringWithDamping: 0.6,
                   initialSpringVelocity: 1,
                   options: [.curveEaseOut],
                   animations: {
                    self.view.layoutIfNeeded()
                   },
                   completion: nil)
  }

  private func showImageInfo() {
    isDisplayingImageInfo = true

    imageViewTopConstraint.constant = -imageView.bounds.height
    UIView.animate(withDuration: 0.125,
                   delay: 0,
                   options: [.curveEaseOut],
                   animations: {
                    self.view.layoutIfNeeded()
                   },
                   completion: nil)
  }

  @objc private func handleDisplayImageInfoTap() {
    if isDisplayingImageInfo {
      hideImageInfo()
    } else {
      showImageInfo()
    }
  }

  @objc private func handleImageContainerTap() {
    if isDisplayingImageInfo {
      hideImageInfo()
    }
  }
}
