//
//  CharactersTableViewController.swift
//  Marvel comics
//
//  Created by Hesham Ali on 8/2/18.
//  Copyright © 2018 Hesham Ali. All rights reserved.
//

import UIKit

class CharactersTableViewController: UIViewController {
    var characterPresenter:CharacterPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        characterPresenter=CharacterPresenter(characterView: self)
        characterPresenter.loadMarvelCharacters()

        // Do any additional setup after loading the view.
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
        
    }
    
    func setCharacterDetails(marvelCharacter: MarvelCharacter) {
        
    }
    
    func setErrorLoading(status: String) {
        
    }
    
    func startLoading() {
        BusyLoader.showBusyIndicator(mainView: self.view)
    }
}
