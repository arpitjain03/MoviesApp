//
//  SplashVC.swift
//  MoviesApp
//
//  Created by Arpit Jain on 16/05/21.
//

import UIKit

class SplashVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureOnViewDidLoad()
    }
    
    // MARK: - Private Methods
    
    /// Function to configure view on DidLoad
    private func configureOnViewDidLoad() {
        // Wait for 2 second to navigate next screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.setRootController()
        }
    }
    
    /// Function to set root controller after app launch
    private func setRootController() {
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.moveToMovieList, sender: nil)
        }
    }
}
