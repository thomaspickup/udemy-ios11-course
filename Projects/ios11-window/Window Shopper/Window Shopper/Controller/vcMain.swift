//
//  ViewController.swift
//  Window Shopper
//
//  Created by Thomas Pickup on 28/08/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcMain: UIViewController {
    @IBOutlet weak var txtWage: tfCurrency!
    @IBOutlet weak var txtPrice: tfCurrency!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var lblHours: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnCalc = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        btnCalc.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        btnCalc.setTitle("Calculate", for: .normal)
        btnCalc.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnCalc.addTarget(self, action: #selector(vcMain.caclulate), for: .touchUpInside)
        
        txtWage.inputAccessoryView = btnCalc
        txtPrice.inputAccessoryView = btnCalc
        
        lblResult.isHidden = true
        lblHours.isHidden = true
    }
    
    @IBAction func onClearTapped(_ sender: Any) {
        txtWage.text = ""
        txtPrice.text = ""
        lblResult.isHidden = true
        lblHours.isHidden = true
        
    }
    
    @objc func caclulate() {
        if let txtWage = txtWage.text, let txtPrice = txtPrice.text {
            if let wage = Double(txtWage), let price = Double(txtPrice) {
                view.endEditing(true)
                
                lblResult.isHidden = false
                lblHours.isHidden = false
                
                lblResult.text = "\(Wage.getHours(forWage: wage, andPrice: price))"
            }
        }

        
    }
}

