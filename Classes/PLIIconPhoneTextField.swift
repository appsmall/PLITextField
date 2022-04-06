//
//  PLIIconPhoneTextField.swift
//  PLITextField
//
//  Created by Rahul Chopra on 06/04/22.
//

import Foundation
import UIKit
import FlagPhoneNumber

@IBDesignable
class PLIIconPhoneTextField: UIView {
    
    /// A UILabel value that identifies the label used to display the icon
    open var iconLabel: UILabel!
    
    /// A UIImageView value that identifies the view used to display the icon
    open var iconImageView: UIImageView!
    open var textField: UITextField!
    open var horizontalLine: UILabel!
    open var phoneCodeBtn: UIButton!
    var phoneCode: String = ""
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
    
    @IBInspectable var iconImage: UIImage? = nil {
        didSet {
            self.iconImageView.image = iconImage
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
    var closureDidSelectPhoneCode: (() -> ())?
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        createIcon()
        setupConstraints()
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
        createIconImageView()
        createTextField()
        createHorizontalLine()
        createPhoneCodeBtn()
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
    fileprivate func createIconImageView() {
        let iconImageView = UIImageView()
        iconImageView.backgroundColor = .clear
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
        self.iconImageView = iconImageView
        addSubview(iconImageView)
    }
    
    /// Creates the icon image view
    fileprivate func createTextField() {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.placeholder = "Phone Number"
        textField.keyboardType = .numberPad
        if UIDevice.deviceType() == .pad {
            textField.font = UIFont.systemFont(ofSize: 17.0)
        } else {
            textField.font = UIFont.systemFont(ofSize: 14.0)
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
    
    fileprivate func createPhoneCodeBtn() {
        if #available(iOS 13.0, *) {
            let phoneCodeBtn = UIButton()
            phoneCodeBtn.setTitle("+91", for: .normal)
            phoneCodeBtn.setImage(UIImage(named: "select_arrow"), for: .normal)
            if UIDevice.deviceType() == .pad {
                phoneCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
            } else {
                phoneCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
            }
            phoneCodeBtn.setTitleColor(.black, for: .normal)
            phoneCodeBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
            phoneCodeBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
            phoneCodeBtn.semanticContentAttribute = .forceRightToLeft
            phoneCodeBtn.addTarget(self, action: #selector(actionPhoneCode(button:)), for: .touchUpInside)
            self.phoneCodeBtn = phoneCodeBtn
            addSubview(phoneCodeBtn)
        }
    }
    
    func setupConstraints() {
        if #available(iOS 13.0, *) {
            horizontalLine.translatesAutoresizingMaskIntoConstraints = false
            horizontalLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            horizontalLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            horizontalLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            horizontalLine.heightAnchor.constraint(equalToConstant: 0.6).isActive = true
            
            iconImageView.translatesAutoresizingMaskIntoConstraints = false
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2).isActive = true
            
            phoneCodeBtn.translatesAutoresizingMaskIntoConstraints = false
            phoneCodeBtn.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10).isActive = true
            phoneCodeBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
            
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.leadingAnchor.constraint(equalTo: phoneCodeBtn.trailingAnchor, constant: 20).isActive = true
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            
            if UIDevice.deviceType() == .pad {
                textField.heightAnchor.constraint(equalToConstant: 32).isActive = true
                textField.bottomAnchor.constraint(equalTo: horizontalLine.topAnchor, constant: -8).isActive = true
                
                iconImageView.heightAnchor.constraint(equalToConstant: 23).isActive = true
                iconImageView.widthAnchor.constraint(equalToConstant: 23).isActive = true
            } else {
                textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
                textField.bottomAnchor.constraint(equalTo: horizontalLine.topAnchor, constant: -5).isActive = true
                
                iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
                iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
            }
            
            
            iconImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor, constant: 0).isActive = true
            phoneCodeBtn.centerYAnchor.constraint(equalTo: textField.centerYAnchor, constant: 0).isActive = true
            
            iconLabel.translatesAutoresizingMaskIntoConstraints = false
            iconLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
            iconLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
            iconLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
    }
    
    
    @objc func actionPhoneCode(button: UIButton) {
        let fpnField = FPNTextField()
        let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
        fpnField.displayMode = .list
//        fpnField.delegate = self
        listController.setup(repository: fpnField.countryRepository)
        listController.didSelect = { [weak self] country in
            self?.phoneCodeBtn.setTitle(country.phoneCode, for: .normal)
            self?.phoneCode = country.phoneCode
        }
        UIApplication.rootViewController().present(listController, animated: true, completion: nil)
        
        self.closureDidSelectPhoneCode?()
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
