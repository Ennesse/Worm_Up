import Foundation
import SwiftUI

struct GameSection: Identifiable {
    let id = UUID()
    let name: String
    let subtitle: String
    let icon: Image

    // MARK: –‑ Sample data
    // A static array that `ChooseView` can iterate over.
    static let all: [GameSection] = [
        GameSection(name: "Memory",    subtitle: "Recall and repeat",   icon: Image("Memory")),
        GameSection(name: "Language",  subtitle: "Words and meaning",   icon: Image(systemName: "brain.fill")),
        GameSection(name: "Attention", subtitle: "Spot and focus",      icon: Image("Attention")),
        GameSection(name: "Logic",     subtitle: "Patterns and puzzles", icon: Image("Logic"))
    ]
}
