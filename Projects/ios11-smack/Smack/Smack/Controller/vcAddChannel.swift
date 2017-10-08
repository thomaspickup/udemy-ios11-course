//
//  vcAddChannel.swift
//  Smack
//
//  Created by Thomas Pickup on 03/09/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcAddChannel: UIViewController {
    // Outlets
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    
    // Actions
    @IBAction func onClosePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onCreatePressed(_ sender: Any) {
        guard let name = txtName.text , txtName.text != "" else { return }
        guard let description = txtDescription.text else { return }
        
        SocketService.instance.addChannel(name: name, description: description) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // Functions
    func setUpView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(vcAddChannel.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        txtName.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        txtDescription.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
