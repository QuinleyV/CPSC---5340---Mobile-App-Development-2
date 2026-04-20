import SwiftUI

struct DiaryHomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var entries: [DiaryEntry] = []
    @State private var showingAddEntry = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if entries.isEmpty {
                    Spacer()
                    
                    Text("No diary entries yet")
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                    Text("Tap the + button to add your first entry.")
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                    
                    Spacer()
                } else {
                    List {
                        ForEach(entries) { entry in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(entry.title)
                                    .font(.headline)
                                
                                Text(entry.content)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                                
                                Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: deleteEntry)
                    }
                }
            }
            .navigationTitle("My Diary")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Logout") {
                        authViewModel.signOut()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddEntry = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddEntry) {
                AddEntryView(entries: $entries)
            }
        }
    }
    
    func deleteEntry(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
    }
}
