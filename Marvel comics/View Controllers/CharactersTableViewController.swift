//
//  CharactersTableViewController.swift
//  Marvel comics
//
//  Created by Hesham Ali on 8/2/18.
//  Copyright © 2018 Hesham Ali. All rights reserved.
//

import UIKit

class CharactersTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var characterPresenter:CharacterPresenter!
    var offset=0
    var marvelCharacters=[MarvelCharacter]()
    @IBOutlet weak var characterTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "Marvel Icon")
        let logoImageView = UIImageView(image:logo)
        self.navigationItem.titleView = logoImageView
        self.characterTableView.delegate = self
        self.characterTableView.dataSource = self
        characterPresenter=CharacterPresenter(characterView: self)
        characterPresenter.loadMarvelCharacters(offset: offset)

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marvelCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as! CharacterTableViewCell
        cell.renderCharacter(marvelCharacter: marvelCharacters[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
        self.loadMoreCharacters(scrollView: scrollView)
        
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
