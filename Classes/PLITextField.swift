//
//  PLITextField.swift
//  PLITextField
//
//  Created by Rahul Chopra on 06/03/22.
//

import Foundation
import UIKit

@IBDesignable
class PLITextField: UIView {
    
    /// A UILabel value that identifies the label used to display the icon
    open var iconLabel: UILabel!
    
    open var textField: UITextField!
    
    open var horizontalLine: UILabel!
    
    var textChanged :(String) -> () = { _ in }
    
    @IBInspectable var activeLineColor: UIColor = .white {
        didSet {
            self.horizontalLine.backgroundColor = activeLineColor
        }
    }
    
    @IBInspectable var inactiveLineColor: UIColor = .white {
        didSet {
            self.horizontalLine.backgroundColor = inactiveLineColor
        }
    }
    
    @IBInspectable var placeholderText: String = "" {
        didSet {
            self.textField.placeholder = placeholderText
            self.iconLabel.text = placeholderText
        }
    }
    
    
    @IBInspectable var textFont: UIFont = .systemFont(ofSize: 15.0) {
        didSet {
            self.textField.font = textFont
        }
    }
    
    @IBInspectable var isSecure: Bool = false {
        didSet {
            self.textField.isSecureTextEntry = isSecure
        }
    }
    
    @IBInspectable var keyboardType: Int = 0 {
        didSet {
            self.textField.keyboardType = UIKeyboardType(rawValue: keyboardType)!
            
//            0: default // Default type for the current input method.
//            1: asciiCapable // Displays a keyboard which can enter ASCII characters
//            2: numbersAndPunctuation // Numbers and assorted punctuation.
//            3: URL // A type optimized for URL entry (shows . / .com prominently).
//            4: numberPad // A number pad with locale-appropriate digits (0-9, ۰-۹, ०-९, etc.). Suitable for PIN entry.
//            5: phonePad // A phone pad (1-9, *, 0, #, with letters under the numbers).
//            6: namePhonePad // A type optimized for entering a person's name or phone number.
//            7: emailAddress // A type optimized for multiple email address entry (shows space @ . prominently).
//            8: decimalPad // A number pad with a decimal point.
//            9: twitter // A type optimized for twitter text entry (easy access to @ #)
        }
    }
    
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        createIcon()
        setupConstraints()
//        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: textField)
        
        textField.addTarget(self, action: #selector(textDidChange(notificaiton:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(textDidBegin(notificaiton:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textDidEnd(notificaiton:)), for: .editingDidEnd)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createIcon()
        setupConstraints()
        textField.addTarget(self, action: #selector(textDidChange(notificaiton:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(textDidBegin(notificaiton:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textDidEnd(notificaiton:)), for: .editingDidEnd)
    }
    
    
    @objc func textDidBegin(notificaiton: NSNotification) {
        self.horizontalLine.backgroundColor = activeLineColor
    }
    
    @objc func textDidEnd(notificaiton: NSNotification) {
        self.horizontalLine.backgroundColor = inactiveLineColor
    }
    
    @objc func textDidChange(notificaiton: NSNotification) {
        if let txtField = notificaiton.object as? UITextField {
            if txtField == textField {
                iconLabel.isHidden = txtField.text == ""
            }
        }
    }
    
    
    /// Creates the both icon label and icon image view
    fileprivate func createIcon() {
        createIconLabel()
        createTextField()
        createHorizontalLine()
    }
    
    // Creates the icon label
    fileprivate func createIconLabel() {
        let iconLabel = UILabel()
        iconLabel.backgroundColor = UIColor.clear
        iconLabel.textAlignment = .center
        iconLabel.text = "Password"
        iconLabel.textAlignment = .left
        if UIDevice.deviceType() == .pad {
            iconLabel.font = UIFont.systemFont(ofSize: 13.0)
        } else {
            iconLabel.font = UIFont.systemFont(ofSize: 11.0)
        }
        iconLabel.textColor = UIColor.init(white: 0.0, alpha: 0.4)
        iconLabel.isHidden = true
        iconLabel.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
        self.iconLabel = iconLabel
        addSubview(iconLabel)
    }
    
    /// Creates the icon image view
    fileprivate func createTextField() {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.placeholder = "Password"
        if UIDevice.deviceType() == .pad {
            textField.font = UIFont.systemFont(ofSize: 17.0)
        } else {
            textField.font = UIFont.systemFont(ofSize: 13.0)
        }
        self.textField = textField
        addSubview(textField)
    }
    
    
    fileprivate func createHorizontalLine() {
        let horizontalLine = UILabel()
        horizontalLine.backgroundColor = UIColor.lightGray
        self.horizontalLine = horizontalLine
        addSubview(horizontalLine)
    }
    
    func setupConstraints() {
        if #available(iOS 13.0, *) {
            horizontalLine.translatesAutoresizingMaskIntoConstraints = false
            horizontalLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            horizontalLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            horizontalLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            horizontalLine.heightAnchor.constraint(equalToConstant: 0.6).isActive = true
            
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2).isActive = true
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            
            if UIDevice.deviceType() == .pad {
                textField.heightAnchor.constraint(equalToConstant: 32).isActive = true
                textField.bottomAnchor.constraint(equalTo: horizontalLine.topAnchor, constant: -8).isActive = true
            } else {
                textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
                textField.bottomAnchor.constraint(equalTo: horizontalLine.topAnchor, constant: -5).isActive = true
            }
            
            
            iconLabel.translatesAutoresizingMaskIntoConstraints = false
            iconLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
            iconLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
            iconLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
    }
    
    
    // MARK: LISTENER FOR TEXT FIELD
    func bind(callback :@escaping (String) -> ()) {
        textChanged = callback
        self.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
  
    @objc func textFieldDidChange(_ textField :UITextField) {
        print(textField.text!)
        textChanged(textField.text!)
    }
}


// MARK: - UIDEVICE
extension UIDevice {
    class func deviceType() -> UIUserInterfaceIdiom {
        return UIScreen.main.traitCollection.userInterfaceIdiom
    }
}


// MARK: - UIAPPLICATION
extension UIApplication {
    class func rootViewController() -> UIViewController {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first!
            if let rootNavVC = window.rootViewController as? UINavigationController {
                return rootNavVC.topViewController!
            } else {
                return window.rootViewController!
            }
        } else {
            let window = UIApplication.shared.keyWindow!
            if let rootNavVC = window.rootViewController as? UINavigationController {
                return rootNavVC.topViewController!
            } else {
                return window.rootViewController!
            }
        }
    }
}
