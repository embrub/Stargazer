//
//  WeatherAstroCell.swift
//  Stargazer
//
//  Created by emi n on 4/13/25.
//
//
//import UIKit
//
//class WeatherAstroCell: UITableViewCell {
//
//    let timeLabel = UILabel()
//    let statusLabel = UILabel()
//    let cloudCoverLabel = UILabel()
//    let instabilityLabel = UILabel()
//    let seeingLabel = UILabel()
//    let transparencyLabel = UILabel()
//    
//    private let rightStack = UIStackView()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupViews() {
//        // Big date label
//        timeLabel.font = UIFont.boldSystemFont(ofSize: 40)
//        timeLabel.text = "4/13"
//        timeLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Smaller fonts for side labels
//        let font = UIFont.boldSystemFont(ofSize: 14)
//        [statusLabel, cloudCoverLabel, instabilityLabel, seeingLabel, transparencyLabel].forEach {
//            $0.font = font
//        }
//
//        statusLabel.text = "Status: ______"
//        statusLabel.font = UIFont.boldSystemFont(ofSize: 20)
//        cloudCoverLabel.text = "Cloud Cover: __"
//        instabilityLabel.text = "Light Pollution: __"
//        seeingLabel.text = "Seeing: __"
//        transparencyLabel.text = "Transparency: __"
//        
//        // Horizontal stacks for pairs
//        let cloudLightStack = UIStackView(arrangedSubviews: [cloudCoverLabel, instabilityLabel])
//        cloudLightStack.axis = .horizontal
//        cloudLightStack.spacing = 0
//        cloudLightStack.distribution = .fillEqually
//        
//        let seeingTransparencyStack = UIStackView(arrangedSubviews: [seeingLabel, transparencyLabel])
//        seeingTransparencyStack.axis = .horizontal
//        seeingTransparencyStack.spacing = 0
//        seeingTransparencyStack.distribution = .fillEqually
//        
//        // Right vertical stack
//        rightStack.axis = .vertical
//        rightStack.spacing = 4
//        rightStack.translatesAutoresizingMaskIntoConstraints = false
//        rightStack.addArrangedSubview(statusLabel)
//        rightStack.addArrangedSubview(cloudLightStack)
//        rightStack.addArrangedSubview(seeingTransparencyStack)
//
//        // Add to contentView
//        contentView.addSubview(timeLabel)
//        contentView.addSubview(rightStack)
//
//        // Constraints
//        NSLayoutConstraint.activate([
//            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            
//            rightStack.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 0),
//            rightStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            rightStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
//            rightStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 0)
//        ])
//    }
//}


//import UIKit
//
//class WeatherAstroCell: UITableViewCell {
//
//    let timeLabel = UILabel()
//    let statusLabel = UILabel()
//    let cloudCoverLabel = UILabel()
//    let instabilityLabel = UILabel()
//    let seeingLabel = UILabel()
//    let transparencyLabel = UILabel()
//    
//    private let rightStack = UIStackView()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupViews() {
//        // Big date label
//        timeLabel.font = UIFont.boldSystemFont(ofSize: 40)
//        timeLabel.text = "4/13"
//        timeLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Right stack of smaller labels
//        let font = UIFont.boldSystemFont(ofSize: 16)
//        [statusLabel, cloudCoverLabel, instabilityLabel, seeingLabel, transparencyLabel].forEach {
//            $0.font = font
//        }
//        
//        cloudCoverLabel.text = "Cloud Cover: __"
//        instabilityLabel.text = "Light Pollution: __"
//        seeingLabel.text = "Seeing: __"
//        transparencyLabel.text = "Transparency: __"
//
//        // Right layout
//        rightStack.axis = .vertical
//        rightStack.distribution = .fillEqually
//        rightStack.spacing = 4
//        rightStack.translatesAutoresizingMaskIntoConstraints = false
//        rightStack.addArrangedSubview(statusLabel)
//        rightStack.addArrangedSubview(cloudCoverLabel)
//        rightStack.addArrangedSubview(instabilityLabel)
//        rightStack.addArrangedSubview(seeingLabel)
//        rightStack.addArrangedSubview(transparencyLabel)
//
//        contentView.addSubview(timeLabel)
//        contentView.addSubview(rightStack)
//
//        // Constraints
//        NSLayoutConstraint.activate([
//            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
//            timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            
//            rightStack.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 20),
//            rightStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80),
//            rightStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
//            rightStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
//        ])
//    }
//}


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
