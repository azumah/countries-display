//
//  CountryListViewController.swift
//  Countries
//
//  Created by Syft on 03/03/2020.
//  Copyright © 2020 Syft. All rights reserved.
//

import UIKit
import CoreData


class CountryListViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var countryTableView: UITableView!
    var countries: [Country]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        countryTableView.rowHeight = UITableView.automaticDimension
        countryTableView.estimatedRowHeight = 100
        countryTableView.dataSource = self
        countryTableView.accessibilityIdentifier = "CountryTable"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        HUD.show(in: view.window!)
        Server.shared.countryList() { (error) in
            
            HUD.dismiss(from: self.view.window!)
            guard error == nil else {
                assertionFailure("There was an error: \(error!)")
                return
            }
            
            self.fetchCountriesFromPersistentStore()
        }
    }
    
    
    // MARK: - Helper Methods
        private func fetchCountriesFromPersistentStore(){
            let countriesFetchRequest: NSFetchRequest<Country> = Country.fetchRequest()
            
            // Get the shared NSManagedObjectContext to perform fetch
            DataStore.shared.viewContext.perform {
                do {
                    // Execute request
                    let data = try countriesFetchRequest.execute()
                    self.countries = data.sorted(by: {
                        $0.name! < $1.name!
                    })
                    self.countryTableView.reloadData()
                }catch {
                    debugPrint("Unable to Execute Fetch Request, \(error.localizedDescription)")
                }
            }
        }
    
    
    // MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryInfoCell") as! CountryTableViewCell
        
        if let country = countries?[indexPath.row] {
            cell.displayCountriesData(name: country.name, capital: country.capital, population: country.population)

        }
        return cell
    }
    
}

