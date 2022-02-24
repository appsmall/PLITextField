//
//  Extension.swift
//  PLITextField
//
//  Created by Rahul Chopra on 06/02/22.
//

import Foundation
import UIKit


extension UIDevice {
    class func deviceType() -> UIUserInterfaceIdiom {
        return UIScreen.main.traitCollection.userInterfaceIdiom
    }
}
