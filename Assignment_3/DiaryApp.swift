import SwiftUI
import FirebaseCore

@main
struct MyDiaryApp: App {
    @State private var firebaseConfigured = false
    
    init() {
        if let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
           let options = FirebaseOptions(contentsOfFile: filePath),
           FirebaseApp.app() == nil {
            FirebaseApp.configure(options: options)
            firebaseConfigured = true
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if firebaseConfigured {
                ContentView()
            } else {
                FirebaseSetupRequiredView()
            }
        }
    }
}
