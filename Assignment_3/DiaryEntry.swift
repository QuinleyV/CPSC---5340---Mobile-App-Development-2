import Foundation

struct DiaryEntry: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let date: Date
}
