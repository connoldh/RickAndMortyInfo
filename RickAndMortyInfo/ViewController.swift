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
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    @IBOutlet weak var locationTableView: UITableView!
    
    
    var characters = Characters()
    var locations = Locations()
//    var locations = ["earth", "moon", "sun"]
    var activityIndicator = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        locationTableView.delegate = self
        locationTableView.dataSource = self
        
        setUpActivityIndicator()
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        locations.getLocations {
            self.locationTableView.reloadData()
        }
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
    
    func loadLocationData(loadAll: Bool) {
        if locations.apiLocationURL.hasPrefix("http") {
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            locations.getLocations {
                self.locationTableView.reloadData()
                self.navigationItem.title = "\(self.locations.locationArray.count) of \(self.locations.totalLocations) Locations"
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
        loadLocationData(loadAll: true)
    }
    
    @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
        switch sortSegmentedControl.selectedSegmentIndex {
        case 0: //characters
            //stuff here
            print("this is case 1")
            tableView.isHidden = false
            locationTableView.isHidden = true
        case 1: //locations
            tableView.isHidden = true
            locationTableView.isHidden = false
        default:
            print("hey you should not have gotten here")
            
        }
        tableView.reloadData()
        locationTableView.reloadData()
    }
}












extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView {
            return characters.characterArray.count
        } else {
            return locations.locationArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == locationTableView {
            let cell = locationTableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
            cell.textLabel?.text = "\(indexPath.row+1). \(locations.locationArray[indexPath.row].name)"
            if indexPath.row == locations.locationArray.count-1 && locations.apiLocationURL.hasPrefix("http") {
                activityIndicator.startAnimating()
                locations.getLocations {
                    self.locationTableView.reloadData()
                    self.navigationItem.title = "\(self.locations.locationArray.count) of \(self.locations.totalLocations) Locations"
                }
            }
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            return cell
        } else {
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCharacterDetail" {
            let destination = segue.destination as! CharacterDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow!
            destination.characterInfo = characters.characterArray[selectedIndex.row]
        }
        
//        if segue.identifier == "ShowLocationInfo" {
//            let destination = segue.destination as!
//            LocationDetailViewController
//            let selectedIndex = locationTableView.indexPathForSelectedRow!
//            destination.
//        }
        
        
    }
}








