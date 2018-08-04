//
//  CharactersTableViewController.swift
//  Marvel comics
//
//  Created by Hesham Ali on 8/2/18.
//  Copyright © 2018 Hesham Ali. All rights reserved.
//

import UIKit

class CharactersTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    var characterPresenter:CharacterPresenter!
    var offset=0
    var marvelCharacters=[MarvelCharacter]()
    var filteredCharacters = [MarvelCharacter]()
    var searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var characterTableView: UITableView!
    @IBOutlet weak var filteredCharactersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "Marvel Icon")
        let logoImageView = UIImageView(image:logo)
        self.navigationItem.titleView = logoImageView
        
        self.searchController.searchResultsUpdater = self
        self.characterTableView.delegate = self
        self.characterTableView.dataSource = self
        self.filteredCharactersTableView.delegate = self
        self.filteredCharactersTableView.dataSource = self
        
        characterPresenter=CharacterPresenter(characterView: self)
        characterPresenter.loadMarvelCharacters(offset: offset)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchIconPressed(_ sender: Any) {
        UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = UIColor.red
        searchController.hidesNavigationBarDuringPresentation = false
    
        // Make this class the delegate and present the search
        self.searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if(searchController.isActive){
            self.filteredCharacters = self.marvelCharacters.filter({ (character: MarvelCharacter) -> Bool in
                return character.name.contains(searchController.searchBar.text!)
            })
            self.characterTableView.isHidden = true
            self.filteredCharactersTableView.isHidden = false
            self.filteredCharactersTableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.characterTableView.isHidden = false
        self.filteredCharactersTableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.characterTableView{
            return marvelCharacters.count
        }
        else{
            return filteredCharacters.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellCharachters = searchController.isActive ? filteredCharacters : marvelCharacters
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as! CharacterTableViewCell
        cell.renderCharacter(marvelCharacter: cellCharachters[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
            view.endEditing(true)
        if(self.characterTableView == scrollView){
            self.loadMoreCharacters(scrollView: scrollView)
        }
    }
    
    func loadMoreCharacters(scrollView: UIScrollView) {
        if !self.marvelCharacters.isEmpty && self.marvelCharacters.count < MarvelCharacter.totalCharacters{
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            
            if offsetY > contentHeight - scrollView.frame.size.height {
                self.offset = self.offset + MarvelCharacter.totalCharactersPerCall
                characterPresenter.loadMarvelCharacters(offset: self.offset)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension CharactersTableViewController:CharacterView{
    func finishLoading() {
        BusyLoader.hideBusyIndicator()
    }
    
    func setCharacters(marvelCharacters: [MarvelCharacter]) {
        self.marvelCharacters.append(contentsOf: marvelCharacters)
        self.characterTableView.reloadData()
    }
    
    func setCharacterDetails(marvelCharacter: MarvelCharacter) {
        
    }
    
    func setErrorLoading(status: String) {
        
    }
    
    func startLoading() {
        BusyLoader.showBusyIndicator(mainView: self.view)
    }
}
