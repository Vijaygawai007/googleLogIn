//
//  ViewController.swift
//  googleLogin
//
//  Created by Prince's Mac on 29/09/23.
//
import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FirebaseFirestore
import GoogleSignInSwift

class ViewController: UIViewController {
    //mark: this is outlet of the login button.
    @IBOutlet weak var googleSignIn: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                // ...
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                // ...
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            // ...
        }
        
    }
    //MARK: THIS IS THE GOOGLE SIGNIN BUTTON.
    @IBAction func googleSignIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self)
        
        func googleSignIn(_ signIn: GoogleSignIn, didSignInFor user: GoogleSignIn.User?, withError error: Error?) {
            if let error = error {
                // Handle sign-in error
                print("Google sign-in error: \(error.localizedDescription)")
            } else if let user = user {
                // Sign-in was successful
               let email = user.email
                let name = user.name
                let profilePhoto = user.picture
                print("Google sign-in successful for user: ")
                // You can access user information using the 'user' object, e.g., user.displayName, user.email, etc.
                
            }
        }
        
        
    }
    
    
}
