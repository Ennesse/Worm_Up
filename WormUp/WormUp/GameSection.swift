import Foundation
import SwiftUI

struct GameSection: Identifiable {
    let id = UUID()
    let name: String
    let subtitle: String
    let icon: String

    // MARK: –‑ Sample data
    // A static array that `ChooseView` can iterate over.
    static let all: [GameSection] = [
        GameSection(name: "Memory",    subtitle: "Recall and repeat",   icon: "brain.fill"),
        GameSection(name: "Language",  subtitle: "Words and meaning",   icon: "brain.fill"),
        GameSection(name: "Attention", subtitle: "Spot and focus",      icon: "brain.fill"),
        GameSection(name: "Logic",     subtitle: "Patterns and puzzles", icon: "brain.fill")
    ]
}
