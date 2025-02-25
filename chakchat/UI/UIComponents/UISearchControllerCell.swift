//
//  UISearchBarCell.swift
//  chakchat
//
//  Created by Кирилл Исаев on 25.02.2025.
//

import UIKit

// MARK: - UISearchControllerCell
final class UISearchControllerCell: UITableViewCell {
    
    // MARK: - Constants
    static let cellIdentifier: String = "SearchControllerCell"
    
    private enum Constants {
        static let size: CGFloat = 40
        static let radius: CGFloat = 20
        static let picX: CGFloat = 10
        static let picY: CGFloat = 10
        static let borderWidth: CGFloat = 5
    }
    
    // MARK: - Properties
    private let name: UILabel = UILabel()
    private let userPhoto: UIImageView = UIImageView()
    private let shimmerLayer: ShimmerView = ShimmerView(
        frame: CGRect(
            x: Constants.picX,
            y: Constants.picY,
            width: Constants.size,
            height: Constants.size
        )
    )
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configure(_ image: URL?, _ name: String) {
        self.name.text = name
        if let url = image {
            loadImage(from: url)
        } else {
            shimmerLayer.isHidden = true
            let color = UIColor.random()
            let image = UIImage.imageWithText(
                text: LocalizationManager.shared.localizedString(for: name),
                size: CGSize(width: Constants.size, height: Constants.size),
                backgroundColor: Colors.background,
                textColor: color,
                borderColor: color,
                borderWidth: Constants.borderWidth
            )
            
            self.userPhoto.image = image
        }
    }
    
    // MARK: - Cell Configuration
    func configureCell() {
        configureShimmerView()
        configurePhoto()
        configureName()
    }
    
    // MARK: - Shimmer View Configuration
    private func configureShimmerView() {
        contentView.addSubview(shimmerLayer)
        shimmerLayer.layer.cornerRadius = Constants.radius
        shimmerLayer.startAnimating()
    }
    
    // MARK: - Photo Configuration
    private func configurePhoto() {
        contentView.addSubview(userPhoto)
        userPhoto.layer.cornerRadius = Constants.radius
        userPhoto.layer.masksToBounds = true
        userPhoto.pinCenterY(contentView)
        userPhoto.pinLeft(contentView.leadingAnchor, Constants.picX)
        userPhoto.setWidth(Constants.size)
        userPhoto.setHeight(Constants.size)
    }
    
    // MARK: - Name Configuration
    private func configureName() {
        contentView.addSubview(name)
        name.font = Fonts.systemR20
        name.textColor = .black
        name.pinCenterY(contentView)
        name.pinLeft(userPhoto.trailingAnchor, Constants.picX)
    }
    
    // MARK: - Image Loading
    private func loadImage(from imageURL: URL) {
        if let cachedImage = ImageCacheManager.shared.getImage(for: imageURL as NSURL) {
            self.shimmerLayer.isHidden = true
            self.userPhoto.image = cachedImage
            return
        }
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    return
                }
                
                ImageCacheManager.shared.saveImage(image, for: imageURL as NSURL)
                
                DispatchQueue.main.async {
                    self?.shimmerLayer.isHidden = true
                    self?.userPhoto.image = image
                }
            }.resume()
        }
    }
}
