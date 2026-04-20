import SwiftUI

struct FirebaseSetupRequiredView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Firebase Setup Required")
                .font(.largeTitle)
                .bold()
            
            Text("This project does not include GoogleService-Info.plist.")
                .multilineTextAlignment(.center)
            
            Text("To run the app, add your Firebase configuration file and enable Email/Password authentication in Firebase.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Steps:")
                    .bold()
                Text("1. Create a Firebase project")
                Text("2. Add an iOS app with the correct bundle identifier")
                Text("3. Download GoogleService-Info.plist")
                Text("4. Add it to the Xcode project")
                Text("5. Enable Email/Password sign-in")
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .padding()
    }
}
