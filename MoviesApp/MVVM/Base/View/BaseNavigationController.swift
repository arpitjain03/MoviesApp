//
//  BaseNavigationController.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    // MARK: - View Controller Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Private Methods

    /// Function to setup Navigation
    private func setupNavigation() {
        
        self.navigationBar.makeTransparent(withTint: UIColor.white)
        self.navigationBar.setTitleFont(UIFont(type: .bold, size: 17.0), color: .white)
    }

}
