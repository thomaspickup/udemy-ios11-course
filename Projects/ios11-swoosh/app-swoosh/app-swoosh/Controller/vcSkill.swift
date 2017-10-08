//
//  vcSkill.swift
//  app-swoosh
//
//  Created by Thomas Pickup on 27/08/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcSkill: UIViewController {
    @IBOutlet weak var btnFinish: BorderButton!
    var player: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onBallerTap(_ sender: Any) {
        selectSkillLevel(skillLevel: "Baller")
    }
    @IBAction func onBeginnerTap(_ sender: Any) {
        selectSkillLevel(skillLevel: "Beginner")
    }
    
    func selectSkillLevel(skillLevel: String) {
        player.strSkillLevel = skillLevel
        btnFinish.isEnabled = true
    }
    
    @IBAction func onFinishTapped(_ sender: Any) {
        print(player.strSkillLevel)
        print(player.strLeague)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vcLeague = segue.destination as? vcLeague {
            vcLeague.player = player
        }
    }
}
