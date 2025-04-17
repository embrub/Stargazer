import UIKit

class WeatherAstroCell: UITableViewCell {

    let timeLabel = UILabel()
//    let dayLabel = UILabel()
    let statusLabel = UILabel()
    let cloudCoverLabel = UILabel()
    let instabilityLabel = UILabel()
    let seeingLabel = UILabel()
    let transparencyLabel = UILabel()
    
    private let leftStack = UIStackView()
    private let rightStack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
//        timeLabel.text = "00:00"
        timeLabel.font = .systemFont(ofSize: 45, weight: .heavy)
        
//        dayLabel.font = UIFont.systemFont(ofSize: 15)
//        dayLabel.text = "Today - Tues"
        
        statusLabel.font = UIFont.systemFont(ofSize: 20)
//        statusLabel.text = "Great conditions!"

        let smallFont = UIFont.boldSystemFont(ofSize: 15)
        [cloudCoverLabel, instabilityLabel, seeingLabel, transparencyLabel].forEach {
            $0.font = smallFont
        }
        
//        cloudCoverLabel.text = "Cloud Cover: __"
//        instabilityLabel.text = "Atmo Instability: __"
//        seeingLabel.text = "Atmo Seeing: __"
//        transparencyLabel.text = "Atmo Transparency: __"

        // Left vertical stack (Date + Status)
        leftStack.axis = .vertical
        leftStack.spacing = 0
        leftStack.translatesAutoresizingMaskIntoConstraints = false
        leftStack.addArrangedSubview(timeLabel)
//        leftStack.addArrangedSubview(dayLabel)
        leftStack.addArrangedSubview(statusLabel)

        // Right vertical stack
        rightStack.axis = .vertical
        rightStack.spacing = 7
        rightStack.translatesAutoresizingMaskIntoConstraints = false
        rightStack.addArrangedSubview(cloudCoverLabel)
        rightStack.addArrangedSubview(instabilityLabel)
        rightStack.addArrangedSubview(seeingLabel)
        rightStack.addArrangedSubview(transparencyLabel)

        contentView.addSubview(leftStack)
        contentView.addSubview(rightStack)

        // Constraints
        NSLayoutConstraint.activate([
            leftStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            leftStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            leftStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            leftStack.widthAnchor.constraint(equalToConstant: 165),

            rightStack.leadingAnchor.constraint(equalTo: leftStack.trailingAnchor, constant: 40),
            rightStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            rightStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rightStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
