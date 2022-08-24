//
//  ViewController.swift
//  BreakingBad
//
//  Created by Nkosi on 2022/07/10.
//

import UIKit

class CharacterTableViewController: UITableViewController {
    

    let favouriteSelcted = CharacterTableViewCell ()
    let apiData = ApiData()
    let loadingViewController = LoadingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAndReloadData()
        
        
    
    }
    
        override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiData.characters?.count ?? 0
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "characterCell") as! CharacterTableViewCell
        
        
        
        
        if let characters = apiData.characters {
            let character = characters[indexPath.row]
            cell.setupContent(character: character)
            
        }
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {
            if let navigationController = segue.destination as? UINavigationController, let detailViewController = navigationController.viewControllers.first as? CharacterDetailViewController, let selectedIndexPath = self.tableView.indexPathForSelectedRow?.row, let selectedCharacter = apiData.characters?[selectedIndexPath] {
                detailViewController.assign(characterDetail: selectedCharacter, apiData: apiData)
                
                
                
            }
        }
    }
    
    fileprivate func fetchAndReloadData() {
        // Do any additional setup after loading the view.
        // loading
        addLoadingIndicator()
        apiData.retrieveCharacters {
            // remove loading
            self.removeLoadingIndicator()
            self.tableView.reloadData()
        }
    }
    
    func addLoadingIndicator() {
        addChild(loadingViewController)
        loadingViewController.view.frame = view.frame
        view.addSubview(loadingViewController.view)
        loadingViewController.didMove(toParent: self)
        tableView.isUserInteractionEnabled = false
    }
    
    func removeLoadingIndicator() {
        tableView.isUserInteractionEnabled = true
        UIView.animate(withDuration: 5) {
            self.loadingViewController.view.backgroundColor = UIColor(white: 1, alpha: 0.1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.loadingViewController.willMove(toParent: nil)
                self.loadingViewController.view.removeFromSuperview()
                self.loadingViewController.removeFromParent()
            }
        }
    }
    
   
    
    
    
    

    
}

