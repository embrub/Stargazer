import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()

    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Accept", for: .normal)
        button.layer.cornerRadius = 7
        button.backgroundColor = .systemBlue
        return button
    }()
    
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white

        titleLabel.text = "This app needs your location to run."
        titleLabel.textColor = .black

        self.view.addSubview(titleLabel)
        self.view.addSubview(button)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 44),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -32)
        ])
    }
    
    @objc private func didTapButton() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
//        let vc = TabBarController()
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let coords = location.coordinate
        LocationDate.shared.latitude  = coords.latitude
        LocationDate.shared.longitude = coords.longitude
        print("Stored coords: \(coords.latitude), \(coords.longitude)")

        DispatchQueue.main.async {
            let vc = TabBarController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }

}
