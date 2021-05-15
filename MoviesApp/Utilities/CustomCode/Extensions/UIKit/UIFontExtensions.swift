//
//  UIFontExtensions.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21

import Foundation
import UIKit

extension UIFont {
    
    /// Enum for App Fonts
    public enum FontType {
        /// medium
        case regular
        /// medium
        case medium
        /// semiBold
        case semiBold
        /// bold
        case bold
        /// extra bold
        case extraBold
        
        var name: String {
            switch self {
            case .regular:
                return "Poppins-Regular"
            case .medium:
                return "Poppins-Medium"
            case .semiBold:
                return "Poppins-SemiBold"
            case .bold:
                return "Poppins-Bold"
            case .extraBold:
                return "Poppins-ExtraBold"
            }
        }
        
    }
    
    /// Enum for App Font sizes
    public enum FontSize {
        /// header
        case header
        /// largeTitle
        case largeTitle
        /// title
        case title
        /// subtitle
        case subtitle
        /// secondarySubtitle
        case secondarySubtitle
        
        var size: CGFloat {
            switch self {
            case .header:
                return 17.0
            case .largeTitle:
                return 20.0
            case .title:
                return 15.0
            case .subtitle:
                return 12.0
            case .secondarySubtitle:
                return 11.0
            }
        }
        
    }
    
    /// This will return the scalled font as per the native iOS setting. Please note that this will work with your custom font as well. :)
    ///
    ///     UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.heavy).scaled
    var scaled: UIFont {
        return UIFontMetrics.default.scaledFont(for: self)
    }
    
    /// Use this method to get the type of font you want
    ///
    /// ## Available Font Type ##
    ///  - .light
    ///  - .regular
    ///  - .semiBold
    ///  - .bold
    ///
    /// ## Usage Example: ##
    /// ````
    /// UIFont(type: .light, size: 14.0)
    /// ````
    ///
    /// - Parameters:
    ///   - type: Pre Define Font Type which you need to pass. The default value will be the .regular
    ///   - size: Size of the Font
    public convenience init(type: FontType = .medium, size: CGFloat) {
        self.init(name: type.name, size: size)!
    }
    
    /// Use this method to get the type of font you want
    ///
    /// ## Available Font Type ##
    ///  - .light
    ///  - .regular
    ///  - .semiBold
    ///  - .bold
    ///
    /// ## Usage Example: ##
    /// ````
    /// UIFont(type: .light, size: .header)
    /// ````
    ///
    /// - Parameters:
    ///   - type: Pre Define Font Type which you need to pass. The default value will be the .regular
    ///   - size: Size of the Font. You can select the size from the pre define enum.
    public convenience init(type: FontType = .medium, size: FontSize) {
        self.init(name: type.name, size: size.size)!
    }
    
}
