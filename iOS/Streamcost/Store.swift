import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    static let freeLimit = 8

    @Published var items: [StreamService] = []
    @Published var isPro: Bool = false

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("streamcost_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: StreamService) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: StreamService) {
        if let idx = items.firstIndex(where: { $0.id == item.id }) {
            items[idx] = item
            save()
        }
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: StreamService) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([StreamService].self, from: data) else {
            items = Store.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    static func seedData() -> [StreamService] {
        [
        StreamService(date: Date().addingTimeInterval(-86400), serviceName: "Netflix", monthlyCost: "15.49", billingDay: "6th"),
        StreamService(date: Date().addingTimeInterval(-172800), serviceName: "Spotify", monthlyCost: "11.99", billingDay: "18th"),
        StreamService(date: Date().addingTimeInterval(-259200), serviceName: "Disney+", monthlyCost: "9.99", billingDay: "22nd")
        ]
    }
}
