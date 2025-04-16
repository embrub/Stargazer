//
//  EventsControllerViewController.swift
//  Stargazer
//
//  Created by emi n on 4/12/25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        
//        self.tabBar.barStyle = .black
//        self.tabBar.tintColor = .label
//        self.tabBar.unselectedItemTintColor = .label
    }

    let vc = WeatherController()

    private func setupTabs() {
        let weather = self.createNavBar(with: "Today", and: UIImage(systemName: "thermometer.variable"), vc: WeatherController())
//        let sky = self.createNavBar(with: "Sky", and: UIImage(systemName: "cloud.moon"), vc: SkyController())
        let celestial = self.createNavBar(with: "Celestial", and: UIImage(systemName: "staroflife.circle.fill"), vc: CelestialController())
        let events = self.createNavBar(with: "Events", and: UIImage(systemName: "note.text.badge.plus"), vc: EventsController())
        
        self.setViewControllers([weather, celestial, events], animated: true)
    }
    
    private func createNavBar(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.textColor = .label
        
        let stack = UIStackView(arrangedSubviews: [titleLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false

        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
        
        let customItem = UIBarButtonItem(customView: containerView)
        vc.navigationItem.leftBarButtonItem = customItem

        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
            containerView.widthAnchor.constraint(equalToConstant: 200)
        ])

        vc.navigationItem.title = ""

        return nav
    }


    
//    private func createNavBar(with title: String, and subtitle: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
//        let nav = UINavigationController(rootViewController: vc)
//        
//        nav.tabBarItem.title = title
//        nav.tabBarItem.image = image
//        
//        nav.viewControllers.first?.navigationItem.title = title
//        nav.viewControllers.first?.navigationItem.prompt = subtitle
////        nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Button", style: .plain, target: nil, action: nil)
//        return nav
//    }


}
