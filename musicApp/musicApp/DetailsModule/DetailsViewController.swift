//
//  DetailsViewController.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//
import UIKit
import musicAPI
protocol DetailsViewControllerProtocol: AnyObject {
  
    func setArtistName(_ text: String)
    func setCollection(_ text: String)
  

}



class DetailsViewController: UIViewController {

    @IBOutlet weak var singLabel: UILabel!
    
    @IBOutlet weak var collectionLabel: UILabel!
    
   
    var presenter: DetailsPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}
extension DetailsViewController: DetailsViewControllerProtocol {
   
    
    func setArtistName(_ text: String) {
        self.singLabel.text = text
    }
    
    func setCollection(_ text: String) {
        self.collectionLabel.text = text
    }
  
    
    
    
}
