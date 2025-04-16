import UIKit

class EventsCell: UITableViewCell {
    
    let dateLabel = UILabel()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    private let infoStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        dateLabel.font = UIFont.boldSystemFont(ofSize: 32)
        dateLabel.textAlignment = .left

        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)

        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.numberOfLines = 0

        infoStack.axis = .vertical
        infoStack.spacing = 4
        infoStack.translatesAutoresizingMaskIntoConstraints = false

        infoStack.addArrangedSubview(dateLabel)
        infoStack.addArrangedSubview(titleLabel)
        infoStack.addArrangedSubview(descriptionLabel)

        contentView.addSubview(infoStack)

        NSLayoutConstraint.activate([
            infoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            infoStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            infoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    func configure(date: String, title: String, content: String) {
        dateLabel.text = date
        titleLabel.text = title
        descriptionLabel.text = content
    }
}
