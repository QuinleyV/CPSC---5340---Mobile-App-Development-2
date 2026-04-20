import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String = ""
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        listenForAuthState()
    }
    
    func listenForAuthState() {
        authStateHandle = Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
        }
    }
    
    func signUp(email: String, password: String) {
        errorMessage = ""
        
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter an email and password."
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            
            self.user = result?.user
        }
    }
    
    func signIn(email: String, password: String) {
        errorMessage = ""
        
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter an email and password."
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            
            self.user = result?.user
        }
    }
    
    func signOut() {
        errorMessage = ""
        
        do {
            try Auth.auth().signOut()
            self.user = nil
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    deinit {
        if let authStateHandle = authStateHandle {
            Auth.auth().removeStateDidChangeListener(authStateHandle)
        }
    }
}
