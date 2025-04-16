struct EventResponseWrapper: Codable {
    let response: EventResponse
}

struct EventResponse: Codable {
    let events: [Event]
}

struct Event: Codable {
    let date: String
    let title: String
    let content: String
    let image: String
}
