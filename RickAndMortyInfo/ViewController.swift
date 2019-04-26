//
//  ViewController.swift
//  RickAndMortyInfo
//
//  Created by John Connolly on 4/25/19.
//  Copyright © 2019 John Connolly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var characters = Characters()
    var activityIndicator = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        setUpActivityIndicator()
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        characters.getCharacters {
            self.tableView.reloadData()
        }
    }
    
    
    func loadData(loadAll: Bool) {
        if characters.apiURL.hasPrefix("http") {
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            characters.getCharacters {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.characters.characterArray.count) of \(self.characters.totalCharacters) Characters"
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                if loadAll {
                    self.loadData(loadAll: loadAll)

                }
            }
        }
    }
    func setUpActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.color = UIColor.cyan
        view.addSubview(activityIndicator)
        
    }
    
    
    
    @IBAction func loadAllPressed(_ sender: UIBarButtonItem) {
        loadData(loadAll: true)
    }
}












extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.characterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row+1). \(characters.characterArray[indexPath.row].name)"
        if indexPath.row == characters.characterArray.count-1 && characters.apiURL.hasPrefix("http") {
            activityIndicator.startAnimating()
            characters.getCharacters {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.characters.characterArray.count) of \(self.characters.totalCharacters) Characters"
            }
        }
        
        self.activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCharacterDetail" {
            let destination = segue.destination as! CharacterDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow!
            destination.characterInfo = characters.characterArray[selectedIndex.row]
        }
        
        
    }
}








