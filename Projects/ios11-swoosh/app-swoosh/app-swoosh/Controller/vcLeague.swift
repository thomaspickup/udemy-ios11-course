//
//  vcLeague.swift
//  app-swoosh
//
//  Created by Thomas Pickup on 27/08/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcLeague: UIViewController {
    var player: Player!
    @IBOutlet weak var btnNext: BorderButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        player = Player()
    }

    @IBAction func unwindFromLeagueVC(unwindSegue: UIStoryboardSegue) {}

    @IBAction func onNextTapped(_ sender: Any) {
        performSegue(withIdentifier: "skillVCSegue", sender: self)
    }
    
    @IBAction func onMaleTapped(_ sender: Any) {
        selectLeague(leagueType: "Male")
    }
    
    @IBAction func onFemaleTapped(_ sender: Any) {
        selectLeague(leagueType: "Female")
    }
    
    @IBAction func onCoEdTapped(_ sender: Any) {
        selectLeague(leagueType: "Co-Ed")
        
    }
    
    func selectLeague(leagueType: String) {
        player.strLeague = leagueType
        btnNext.isEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vcSkill = segue.destination as? vcSkill {
            vcSkill.player = player
        }
    }
}
