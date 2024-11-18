import UIKit
import SnapKit
import Kingfisher

class NewsArticleCell: UITableViewCell {
    private let containerView = UIView()
    private let articleImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let likeButton = UIButton()
    
    var likeButtonTapped: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.addSubview(articleImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(likeButton)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.1
        
        articleImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(12)
            make.width.height.equalTo(80)
            make.bottom.lessThanOrEqualToSuperview().offset(-12)
        }
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.clipsToBounds = true
        articleImageView.layer.cornerRadius = 8
        
        likeButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(12)
            make.width.height.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(articleImageView.snp.right).offset(12)
            make.right.equalTo(likeButton.snp.left).offset(-12)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(articleImageView.snp.right).offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        // Styling
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.numberOfLines = 2
        
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 2
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        likeButton.tintColor = .systemRed
        likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        likeButton.isSelected = article.isLiked
        if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
            articleImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "newspaper"))
        } else {
            articleImageView.image = UIImage(systemName: "newspaper")
        }
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        likeButtonTapped?()
        
        // Add a small animation when like button is tapped
        UIView.animate(withDuration: 0.2) {
            sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                sender.transform = .identity
            }
        }
    }
}
