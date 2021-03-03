//
//  RedmineAPI.swift
//  TimeClock
//
//  Created by Zac Johnson on 3/3/21.
//

import Foundation
import Combine

enum RedmineAPI {
    static let agent = Agent()
    static let base = URL(string: "https://redmine.lightningkite.com")!
    static let redmineKey = UserDefaults.standard.string(forKey: SaveKey.redmineKey.rawValue)
}

extension RedmineAPI {
    
    static func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    
    static func activityTypes() -> AnyPublisher<TimeEntryActivities, Error> {
        var request = URLRequest(url: base.appendingPathComponent("enumerations/time_entry_activities.json"))
        request.addValue(redmineKey ?? "missing", forHTTPHeaderField: "X-Redmine-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return run(request)
    }
}


struct TimeEntryActivities: Codable {
    let activities: [TimeEntryActivity]
    
    enum CodingKeys: String, CodingKey {
        case activities = "time_entry_activities"
    }
}

// MARK: - TimeEntryActivity
struct TimeEntryActivity: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
    let isDefault, active: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case isDefault = "is_default"
        case active
    }
}

class ActivityTypeHelper: ObservableObject {
    @Published var activities: [TimeEntryActivity] = []
    var cancellationToken: AnyCancellable?
    
    init() {
        getActivityTypes()
    }
    
    private func getActivityTypes() {
        cancellationToken = RedmineAPI.activityTypes()
            .mapError({ error -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                      self.activities = $0.activities
                  })
    }
}
