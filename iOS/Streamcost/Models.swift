import Foundation

struct StreamService: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date = Date()
    var serviceName: String
    var monthlyCost: String
    var billingDay: String
}
