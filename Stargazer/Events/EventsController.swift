import UIKit
import EventKit
import EventKitUI
import SafariServices

class EventsController: UIViewController, UITableViewDelegate, UITableViewDataSource, EKEventEditViewDelegate {

    private let tableView = UITableView()
    
    var events: [Event] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
                
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(EventsCell.self, forCellReuseIdentifier: "EventsCell")
        tableView.delegate = self
        tableView.dataSource = self
        print("Set tableView dataSource: \(tableView.dataSource != nil)")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        fetchEvents()

    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Returning \(events.count) rows")
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventsCell", for: indexPath) as? EventsCell else {
            return UITableViewCell()
        }
        
        let event = events[indexPath.row]
        cell.configure(date: event.date, title: event.title, content: event.content)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        
        let alert = UIAlertController(title: event.title, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Add to Calendar", style: .default, handler: { _ in
            self.addEventToCalendar(title: event.title, dateString: event.date)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func addEventToCalendar(title: String, dateString: String) {
        let eventStore = EKEventStore()
        
        let requestAccess: (_ completion: @escaping (Bool, Error?) -> Void) -> Void = { completion in
            if #available(iOS 17.0, *) {
                eventStore.requestWriteOnlyAccessToEvents { granted, error in
                    completion(granted, error)
                }
            } else {
                eventStore.requestAccess(to: .event) { granted, error in
                    completion(granted, error)
                }
            }
        }
        
        requestAccess { granted, error in
            guard granted, error == nil else {
                print("Calendar access denied or error: \(String(describing: error))")
                return
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            guard let startDate = formatter.date(from: dateString) else {
                print("Invalid date format: \(dateString)")
                return
            }
            
            let event = EKEvent(eventStore: eventStore)
            event.title = title
            event.startDate = startDate
            event.endDate = startDate.addingTimeInterval(3600) // 1‑hour default
            
            DispatchQueue.main.async {
                let editVC = EKEventEditViewController()
                editVC.eventStore = eventStore
                editVC.event = event
                editVC.editViewDelegate = self
                self.present(editVC, animated: true)
            }
        }
    }
    
    func fetchEvents() {
        let headers = [
            "x-rapidapi-key": "5428dc275cmsh78e2719530d796fp1ed4b2jsn9896d146fcc5",
            "x-rapidapi-host": "astronomy-calendar.p.rapidapi.com"
        ]

        let urlString = "https://astronomy-calendar.p.rapidapi.com/events.php?year=2024"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("❌ Error: \(error)")
                return
            }

            guard let data = data else {
                print("❌ No data returned")
                return
            }

            do {
                let decoded = try JSONDecoder().decode([Event].self, from: data)
                self?.events = decoded
                
                DispatchQueue.main.async {
//                    print("tableView is nil: \(self?.tableView == nil)")
//                    print("Fetched \(self?.events.count ?? 0) events")
                    self?.tableView.reloadData()
                }
            } catch {
                print("❌ JSON Decoding error: \(error)")
                if let jsonStr = String(data: data, encoding: .utf8) {
                    print("Returned JSON: \(jsonStr)")
                }
            }
        }

        dataTask.resume()
    }

}


