import UIKit
import Combine

final class LanguageCell: UITableViewCell {
    static let cellIdentifier = "LanguageCell"

    private let languageLabel = UILabel()
    private let checkmarkImageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    private var cancellables = Set<AnyCancellable>()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    private func configureCell() {
        contentView.addSubview(languageLabel)
        contentView.addSubview(checkmarkImageView)
        contentView.addSubview(activityIndicator)
        
        checkmarkImageView.image = UIImage(systemName: "checkmark")
        checkmarkImageView.tintColor = .orange
        checkmarkImageView.isHidden = true

        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        
        // Расположение
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            languageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            languageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            checkmarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkmarkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            activityIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(title: String, isSelected: Bool, isLoading: Bool) {
        languageLabel.text = title
        checkmarkImageView.isHidden = isLoading || !isSelected
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
