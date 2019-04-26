//
//  DetailViewController.swift
//  RickAndMortyInfo
//
//  Created by John Connolly on 4/25/19.
//  Copyright © 2019 John Connolly. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var typeStaticLabel: UILabel!
    @IBOutlet weak var statusStaticLabel: UILabel!
    
    var characterInfo = CharacterInfo()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInterface()

    }
    
    func updateUserInterface() {
        nameLabel.text = characterInfo.name
        originLabel.text = characterInfo.origin
        locationLabel.text = characterInfo.location
        speciesLabel.text = characterInfo.species
        typeLabel.text = characterInfo.type
        statusLabel.text = characterInfo.status
        guard let url = URL(string: characterInfo.image) else { return }
        do {
            let data = try Data(contentsOf: url)
            characterImageView.image = UIImage(data: data)
        } catch {
            print("ERROR: error thrown trying to get image form URL: \(url)")
        }
        if characterInfo.status == "Dead" {
            statusLabel.textColor = UIColor.red
        } else if characterInfo.status == "Alive" {
            statusLabel.textColor = UIColor.green
        }
        
        if characterInfo.type == "" {
            typeStaticLabel.isHidden = true
            typeLabel.isHidden = true
            
        }
        
        
    }
    
    

}
