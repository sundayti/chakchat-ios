//
//  UISearchBarCell.swift
//  chakchat
//
//  Created by Кирилл Исаев on 25.02.2025.
//

import UIKit

final class UISearchControllerCell: UITableViewCell {
    
    static let cellIdentifier: String = "SearchControllerCell"
    
    private let name: UILabel = UILabel()
    private let userPhoto: UIImageView = UIImageView()
    private let shimmerLayer: ShimmerView = ShimmerView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    
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
            self.userPhoto.image = UIImage(systemName: "camera.circle")
        }
    }
    
    func configureCell() {
        configureShimmerView()
        configurePhoto()
        configureName()
    }
    
    private func configureShimmerView() {
        contentView.addSubview(shimmerLayer)
        shimmerLayer.layer.cornerRadius = 25
        shimmerLayer.startAnimating()
    }
    
    private func configurePhoto() {
        contentView.addSubview(userPhoto)
        userPhoto.tintColor = UIColor.random()
        userPhoto.layer.cornerRadius = 25
        userPhoto.layer.masksToBounds = true
        userPhoto.pinCenterY(contentView)
        userPhoto.pinLeft(contentView.leadingAnchor, 10)
        userPhoto.setWidth(50)
        userPhoto.setHeight(50)
    }
    
    private func configureName() {
        contentView.addSubview(name)
        name.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        name.textColor = .black
        name.pinCenterY(contentView)
        name.pinLeft(userPhoto.trailingAnchor, 10)
    }
    
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
