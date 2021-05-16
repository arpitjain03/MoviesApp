//
//  Constants.swift
//  MoviesApp
//
//  Created by Arpit Jain on 14/05/21

import Foundation
import UIKit

/// General object of Application Delegate
let APPDELEGATE: AppDelegate                   =   UIApplication.shared.delegate as! AppDelegate

/// General object of FileManager
let FILEMANAGER                                =   FileManager.default

/// General object of Main Bundle
let MAINBUNDLE                                 =   Bundle.main

/// General object of Main Thread
let MAINTHREAD                                 =   Thread.main

/// General object of Main Screen
let MAINSCREEN                                 =   UIScreen.main

/// General object of UserDefaults
let USERDEFAULTS                               =   UserDefaults.standard

/// General object of UIApplication
let APPLICATION                                 =  UIApplication.shared

/// General object of Current Device
let CURRENTDEVICE                              =   UIDevice.current

/// General object of Current Landuage
let CURRENTLANGUAGE                            =   NSLocale.current.languageCode
