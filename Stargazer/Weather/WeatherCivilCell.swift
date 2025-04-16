//
//  WeatherCivilCell.swift
//  Stargazer
//
//  Created by emi n on 4/13/25.
//

import UIKit

class WeatherCivilCell: UITableViewCell {

    let windLabel = UILabel()
    let tempLabel = UILabel()
    let humidityLabel = UILabel()
    let sunLabel = UILabel()
    let percipitationLabel = UILabel()
    
    private let stack = UIStackView()
    private let percipRowStack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let smallFont = UIFont.systemFont(ofSize: 15)
        [windLabel, tempLabel, humidityLabel, percipitationLabel].forEach {
            $0.font = smallFont
        }
        
//        sunLabel.text = "Sunrise: 5:50AM  |  Sunset: 8PM"
//        windLabel.text = "Wind: 2 mph  |  North"
//        tempLabel.text = "Temp: 72"
//        humidityLabel.text = "Humidity: 10%"
//        percipitationLabel.text = "Percipitation: 4%"

        // Horizontal stack for precipitation + button
        percipRowStack.axis = .horizontal
        percipRowStack.spacing = 8
        percipRowStack.distribution = .fill
        percipRowStack.alignment = .center
        percipRowStack.translatesAutoresizingMaskIntoConstraints = false
        percipRowStack.addArrangedSubview(percipitationLabel)

        // Main vertical stack
        stack.axis = .vertical
        stack.spacing = 7
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(windLabel)
        stack.addArrangedSubview(tempLabel)
        stack.addArrangedSubview(humidityLabel)
        stack.addArrangedSubview(percipRowStack)

        contentView.addSubview(stack)

        // Constraints
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
