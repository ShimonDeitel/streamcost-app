import SwiftUI

enum Theme {
    static let background = Color(red: 0.082, green: 0.059, blue: 0.118)
    static let accent = Color(red: 0.486, green: 0.302, blue: 0.749)
    static let accent2 = Color(red: 0.890, green: 0.698, blue: 0.235)
    static let cardBackground = Color(.secondarySystemGroupedBackground)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)
}
