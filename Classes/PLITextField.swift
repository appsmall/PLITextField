//
//  PLITextField.swift
//  PLITextField
//
//  Created by Rahul Chopra on 27/01/22.
//

import Foundation
import UIKit

@IBDesignable
class PLITextField: UIView {
    
    /// A UILabel value that identifies the label used to display the icon
    open var iconLabel: UILabel!
    
    open var textField: UITextField!
    
    open var horizontalLine: UILabel!
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(notificaiton:)), name: UITextField.textDidChangeNotification, object: textField)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidBegin(notificaiton:)), name: UITextField.textDidBeginEditingNotification, object: textField)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidEnd(notificaiton:)), name: UITextField.textDidEndEditingNotification, object: textField)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createIcon()
        setupConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(notificaiton:)), name: UITextField.textDidChangeNotification, object: textField)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidBegin(notificaiton:)), name: UITextField.textDidBeginEditingNotification, object: textField)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidEnd(notificaiton:)), name: UITextField.textDidEndEditingNotification, object: textField)
    }
    
    
    @objc func textDidBegin(notificaiton: NSNotification) {
        self.horizontalLine.backgroundColor = AppColors.appOrange
    }
    
    @objc func textDidEnd(notificaiton: NSNotification) {
        self.horizontalLine.backgroundColor = AppColors.appGray
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
            iconLabel.font = UIFont.systemFont(ofSize: 14.0)
        } else {
            iconLabel.font = UIFont.systemFont(ofSize: 12.0)
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
        textField.delegate = self
        if UIDevice.deviceType() == .pad {
            textField.font = UIFont.systemFont(ofSize: 18.0)
        } else {
            textField.font = UIFont.systemFont(ofSize: 15.0)
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


extension PLITextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
