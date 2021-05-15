//
//  UITableViewExtensions.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21.
//

import Foundation
import UIKit

// MARK: - Methods
public extension UITableView {

    /// Dequeue reusable UITableViewCell using class name
    ///
    /// - Parameter name: UITableViewCell type
    /// - Returns: UITableViewCell object with associated class name (optional value)
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: name)) as? T
    }
    
    /// Register UITableViewCell using class name
    ///
    /// - Parameter name: UITableViewCell type
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }
    
    /// Register UITableViewCell using class name
    ///
    /// - Parameters:
    ///   - nib: Nib file used to create the tableView cell.
    ///   - name: UITableViewCell type.
    func registerNib<T: UITableViewCell>(withCellClass name: T.Type) {
        register(UINib(nibName: String(describing: name), bundle: Bundle.main), forCellReuseIdentifier: String(describing: name))
    }
    
}
