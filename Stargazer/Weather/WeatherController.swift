import UIKit

class WeatherController: UIViewController {
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(WeatherAstroCell.self, forCellReuseIdentifier: "WeatherAstroCell")
        tv.register(WeatherCivilCell.self, forCellReuseIdentifier: "WeatherCivilCell")
        return tv
    }()
    
    private var dataPoints: [DataPoint] = []
    private var expanded: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchWeather()
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      tableView.frame = view.bounds
    }
    
    private func fetchWeather() {
        guard let lon = LocationDate.shared.longitude,
              let lat = LocationDate.shared.latitude else {
            print("missing coordinates")
            return
        }
        
        var components = URLComponents(string: "https://www.7timer.info/bin/api.pl")!
        components.queryItems = [
          URLQueryItem(name: "lon", value: "\(lon)"),
          URLQueryItem(name: "lat", value: "\(lat)"),
          URLQueryItem(name: "product", value: "astro"),
          URLQueryItem(name: "output", value: "json")
        ]

        guard let url = components.url else {
            print("bad components:", components)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("fetch error:", error ?? "")
                return
            }
//            if let json = String(data: data, encoding: .utf8) {
//              print("🌐 JSON response:", json)
//            }
            do {
                let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)
                // take first 24 hours
                let first24 = Array(weather.dataseries.prefix(24))
                self.dataPoints = first24
                self.expanded = Array(repeating: false, count: first24.count)
                DispatchQueue.main.async {
//                    print("✅ fetched weather: \(first24)")
                    self.tableView.reloadData()
                }
            } catch {
                print("decode error:", error)
            }
        }.resume()
    }
    
    private func conditionStatus(for point: DataPoint) -> String {
        var good = 0, ok = 0, bad = 0

        //https://www.geeksforgeeks.org/swift-switch-statement/
        switch point.cloudcover {
        case 0...30: good += 1
        case 31...60: ok += 1
        default: bad += 1
        }

        if point.liftedIndex > 0 {
            good += 1
        } else if point.liftedIndex >= -4 {
            ok += 1
        } else {
            bad += 1
        }

        if point.precType.lowercased() != "none" {
            bad += 1
        } else {
            good += 1
        }

        switch point.seeing {
        case 1...2: good += 1
        case 3...5: ok += 1
        default: bad += 1
        }

        switch point.transparency {
        case 1...2: good += 1
        case 3...5: ok += 1
        default: bad += 1
        }

        switch point.rh2m {
        case ..<70: good += 1
        case 70...80: ok += 1
        default: bad += 1
        }

        switch point.wind10m.speed {
        case 0...10: good += 1
        case 11...17: ok += 1
        default: bad += 1
        }
        
        if good > ok && good > bad {
            return "Great conditions!"
        } else if ok > good && ok > bad {
            return "OK conditions"
        } else {
            return "Bad conditions"
        }
    }
}

extension WeatherController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataPoints.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expanded[section] ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let point = dataPoints[indexPath.section]
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "WeatherAstroCell",
                for: indexPath
            ) as! WeatherAstroCell
            
            // hour label: 3->0, 6->1, 9->2 ...
            let hourIndex = point.timepoint / 3 - 1
            cell.timeLabel.text = String(format: "%02d:00", hourIndex)
            
            cell.cloudCoverLabel.text = "Cloud Cover: \(point.cloudcover)%"
            cell.instabilityLabel.text = "Atmo Instability: \(point.liftedIndex)"
            cell.transparencyLabel.text = "Atmo Transparency: \(point.transparency)"
            cell.seeingLabel.text = "Atmo Seeing: \(point.seeing)"
            
            let status = conditionStatus(for: point)
            if status == "Great conditions!" {
                cell.statusLabel.textColor = .systemGreen
            } else if status == "OK conditions" {
                cell.statusLabel.textColor = .systemOrange
            } else {
                cell.statusLabel.textColor = .systemRed
            }
            cell.statusLabel.text = "\(status)"

            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "WeatherCivilCell",
                for: indexPath
            ) as! WeatherCivilCell
            
            cell.windLabel.text = "Wind: \(point.wind10m.speed) mph | Direction: \(point.wind10m.direction)"
            cell.tempLabel.text = "Temp: \(point.temp2m)°C"
            cell.humidityLabel.text = "Humidity: \(point.rh2m)%"
            cell.percipitationLabel.text = "Precipitation: \(point.precType)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // only toggle when tapping the astro row
        if indexPath.row == 0 {
            expanded[indexPath.section].toggle()
            tableView.reloadSections([indexPath.section], with: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 130 : 160
    }
}


