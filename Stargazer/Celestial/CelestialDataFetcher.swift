import Foundation

// fetches celestial position data and decodes it into `AltitudeData`.
class CelestialDataFetcher {
    private struct APIResponse: Codable {
        let data: TableWrapper
    }

    private struct TableWrapper: Codable {
        let table: CelestialTable
    }

    private struct CelestialTable: Codable {
        let rows: [CelestialRow]
    }

    private struct CelestialRow: Codable {
        let cells: [CelestialCell]
    }

    private struct CelestialCell: Codable {
        let date: String
        let name: String
        let position: PositionInfo
    }

    private struct PositionInfo: Codable {
        let horizontal: HorizontalPosition
    }

    private struct HorizontalPosition: Codable {
        let altitude: Angle
    }

    private struct Angle: Codable {
        let degrees: String
    }

    static func fetchCelestialData(at time: String,
                                   completion: @escaping ([AltitudeData]) -> Void) {
        let baseURL = "https://api.astronomyapi.com/api/v2/bodies/positions"
        var components = URLComponents(string: baseURL)!

        let today = Date.now
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateStr = formatter.string(from: today)

        components.queryItems = [
            URLQueryItem(name: "latitude",  value: LocationDate.shared.latitude?.description),
            URLQueryItem(name: "longitude", value: LocationDate.shared.longitude?.description),
            URLQueryItem(name: "from_date", value: dateStr),
            URLQueryItem(name: "to_date",   value: dateStr),
            URLQueryItem(name: "time",      value: time),
            URLQueryItem(name: "bodies",    value: "Mercury,Venus,Mars,Jupiter,Saturn,Uranus,Neptune"),
            URLQueryItem(name: "elevation", value: "0"),
            URLQueryItem(name: "output",    value: "table")
        ]

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        let credentials = "67495e07-d0e6-4399-b46b-a8cc51b152d6:5a0c671e804672f5257e6e7ba13e94da63bfc79ac15eb5a403e8c43f55667bea56ea432ad799a03ec244656144c5ee7527f2b16c86b3dd770a631b403650275d431aa0915c1a657a859524675df9887a6862cae60da757a27514575752edb2c7e4b738bd8a8d08ee55e7f4f2744eda3e"
        let loginData = Data(credentials.utf8)
        request.setValue("Basic \(loginData.base64EncodedString())", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion([]) }
                return
            }

            do {
                let decoded = try JSONDecoder().decode(APIResponse.self, from: data)
                var result: [AltitudeData] = []

                let isoParser = ISO8601DateFormatter()
                isoParser.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                let hourFormatter = DateFormatter()
                hourFormatter.dateFormat = "HH:mm"

                for row in decoded.data.table.rows {
                    for cell in row.cells {
                        // parse timestamp into HH:mm
                        let hourLabel: String
                        if let dt = isoParser.date(from: cell.date) {
                            hourLabel = hourFormatter.string(from: dt)
                        } else {
                            let comps = cell.date.split(separator: "T").last?.split(separator: ":")
                            if let h = comps?[0], let m = comps?[1] {
                                hourLabel = "\(h):\(m)"
                            } else {
                                hourLabel = String(cell.date.prefix(5))
                            }
                        }

                        if let altitude = Double(cell.position.horizontal.altitude.degrees) {
                            result.append(AltitudeData(hour: hourLabel,
                                                       altitude: altitude,
                                                       object: cell.name))
                        }
                    }
                }

                DispatchQueue.main.async {
                    completion(result)
                }
            } catch {
                print("Decode error for \(time):", error)
                DispatchQueue.main.async { completion([]) }
            }
        }.resume()
    }

    static func fetchCelestialDataForHours(_ hours: [String],
                                           completion: @escaping ([AltitudeData]) -> Void) {
        var allData: [AltitudeData] = []
        let group = DispatchGroup()

        for time in hours {
            group.enter()
            fetchCelestialData(at: time) { data in
                allData.append(contentsOf: data)
                group.leave()
            }
        }

        group.notify(queue: .main) {
            completion(allData.sorted(by: { $0.hour < $1.hour }))
        }
    }
}
