//
//  ViewController.swift
//  app-swoosh
//
//  Created by Thomas Pickup on 27/08/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcWelcome: UIViewController {
    @IBOutlet weak var imgSwoosh: UIImageView!
    @IBOutlet weak var imgBG: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        imgSwoosh.frame = CGRect(x: view.frame.size.width / 2 - imgSwoosh.frame.width / 2, y: 50 , width: imgSwoosh.frame.size.width, height: imgSwoosh.frame.size.height)
//
//        imgBG.frame = view.frame
        
    }

    @IBAction func unwindFromSkillVC(unwindSegue: UIStoryboardSegue) {
        
    }
    @IBAction func onTapGetStarted(_ sender: Any) {
        performSegue(withIdentifier: "leagueVCSegue", sender: self)
    }


}

