import SwiftUI

struct AddEntryView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var entries: [DiaryEntry]
    
    @State private var title = ""
    @State private var content = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField("Entry Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                
                TextEditor(text: $content)
                    .frame(minHeight: 250)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4))
                    )
            }
            .padding()
            .navigationTitle("New Entry")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveEntry()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                              content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
    
    func saveEntry() {
        let newEntry = DiaryEntry(
            title: title,
            content: content,
            date: Date()
        )
        
        entries.append(newEntry)
        dismiss()
    }
}
