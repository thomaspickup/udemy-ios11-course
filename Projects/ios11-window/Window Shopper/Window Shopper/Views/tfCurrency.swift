//
//  tfCurrency.swift
//  Window Shopper
//
//  Created by Thomas Pickup on 28/08/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

@IBDesignable
class tfCurrency: UITextField {
    override func draw(_ rect: CGRect) {
        let size: CGFloat = 20
        let lblCurrency = UILabel(frame: CGRect(x: 5, y: frame.size.height / 2 - size / 2, width: size, height: size))
        lblCurrency.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0.8041648327)
        lblCurrency.textAlignment = .center
        lblCurrency.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        lblCurrency.layer.cornerRadius = 5.0
        lblCurrency.clipsToBounds = true
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        lblCurrency.text = formatter.currencySymbol
        
        addSubview(lblCurrency)
    }
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        customizeView()
    }
    func customizeView() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.25)
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
        textAlignment = .center
        
        if let p = placeholder {
            let place = NSAttributedString(string: p, attributes: [.foregroundColor: UIColor.white])
            attributedPlaceholder = place
            textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}
