import UIKit
import SwiftUI
import Charts

class CelestialController: UIViewController {
    let tableView = UITableView()
    let chartContainer = UIView()
    let titleLabel = UILabel()

    private let visibilityDefaultsKey = "VisibleObjects"
    private var chartHostingController: UIHostingController<AltitudeChart>?

    var allData: [AltitudeData] = []
    var visibleObjects: Set<String> = []
    let availableObjects = ["Moon", "Mercury", "Venus", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.register(CelestialCell.self, forCellReuseIdentifier: "celestialCell")

        loadVisibilityFromDefaults()
        setupChart()
        setupTableView()
        fetchAllData()
    }

    private func setupChart() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        let finalDateString = formatter.string(from: Date()) // or Date.now
        
        titleLabel.text = "Altitude Graph for \(finalDateString) 0:00-23:00 UTC"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        chartContainer.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
        view.addSubview(chartContainer)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: 170),
            chartContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            chartContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chartContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chartContainer.heightAnchor.constraint(equalToConstant: 400)
        ])

        reloadChart()
    }

    private func reloadChart() {
        chartHostingController?.willMove(toParent: nil)
        chartHostingController?.view.removeFromSuperview()
        chartHostingController?.removeFromParent()

        let chartView = AltitudeChart(allData: allData, visibleObjects: visibleObjects)
        let hostingController = UIHostingController(rootView: chartView)

        addChild(hostingController)
        chartContainer.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: chartContainer.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: chartContainer.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: chartContainer.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: chartContainer.trailingAnchor),
        ])

        hostingController.didMove(toParent: self)
        chartHostingController = hostingController
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: chartContainer.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func loadVisibilityFromDefaults() {
        if let saved = UserDefaults.standard.array(forKey: visibilityDefaultsKey) as? [String] {
            visibleObjects = Set(saved)
        } else {
            visibleObjects = Set(availableObjects)
        }
    }

    private func fetchAllData() {
        let hours = (0...23).map { String(format: "%02d:00:00", $0) } +
                    (0...5).map  { String(format: "%02d:00:00", $0) }

        CelestialDataFetcher.fetchCelestialDataForHours(hours) { data in
            self.allData = data
            self.reloadChart()
            self.tableView.reloadData()
        }
    }
}

extension CelestialController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        availableObjects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = availableObjects[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "celestialCell", for: indexPath) as? CelestialCell else {
            return UITableViewCell()
        }

        cell.titleLabel.text = object
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        cell.detailLabel.font = UIFont.systemFont(ofSize: 16)

        let dataForObject = allData.filter { $0.object == object }
        if let maxPoint = dataForObject.max(by: { $0.altitude < $1.altitude }) {
            let symbol = maxPoint.altitude >= 0 ? "↗" : "↘"
            
            let color: UIColor
            if maxPoint.altitude < 0 {
                color = .systemRed
            } else if maxPoint.altitude <= 20 {
                color = .systemOrange
            } else {
                color = .systemGreen
            }
            
            cell.detailLabel.text = "\(symbol) Max: \(String(format: "%.1f°", maxPoint.altitude)) at \(maxPoint.hour)"
            cell.detailLabel.textColor = color
        } else {
            cell.detailLabel.text = "No data"
            cell.detailLabel.textColor = .secondaryLabel
        }

        cell.accessoryType = visibleObjects.contains(object) ? .checkmark : .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = availableObjects[indexPath.row]
        if visibleObjects.contains(object) {
            visibleObjects.remove(object)
        } else {
            visibleObjects.insert(object)
        }
        UserDefaults.standard.set(Array(visibleObjects), forKey: visibilityDefaultsKey)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        reloadChart()
    }
}
