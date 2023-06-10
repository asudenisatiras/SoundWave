//
//  DetailsViewController.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//
import UIKit
//import musicAPI
import SafariServices
import AVFoundation

protocol DetailsViewControllerProtocol: AnyObject {
    func setArtistImage(_ image: UIImage)
    func setArtistName(_ text: String)
    func setCollection(_ text: String)
    func setSongName(_ text: String)
    func setSongPrice(_ text: String)
    func setCollectionPrice(_ text: String)
    func setSongType(_ text: String)
  
}



class DetailsViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var singLabel: UILabel!
    
    @IBOutlet weak var collectionLabel: UILabel!
    
    
    @IBOutlet weak var songImage: UIImageView!
    
    
    @IBOutlet weak var songName: UILabel!
    
    @IBOutlet weak var songPriceLabel: UILabel!
    
    
    @IBOutlet weak var collectionPriceLabel: UILabel!
    
    @IBOutlet weak var typeOfSong: UILabel!
    
    var presenter: DetailsPresenterProtocol!
    var audioPlayer: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    
    @IBAction func singerDetails(_ sender: UIButton) {
        guard let artistURLString = presenter.getSource()?.artistViewUrl,
                     let artistURL = URL(string: artistURLString) else {
                   return
               }
               let safariViewController = SFSafariViewController(url: artistURL)
               present(safariViewController, animated: true, completion: nil)
           }
    
    
    @IBAction func playSelectedSong(_ sender: UIButton) {
        
         }
            
    }
    
    
    
    
    
    
    


extension DetailsViewController: DetailsViewControllerProtocol {
    func setSongType(_ text: String) {
        self.typeOfSong.text = text 
    }
    
    
    func setCollectionPrice(_ text: String) {
        self.collectionPriceLabel.text = text
    }
    
    
    func setSongPrice(_ text: String) {
        self.songPriceLabel.text = text
    }
    
    func setSongName(_ text: String) {
        self.songName.text = text
    }
    
    func setArtistImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.songImage.image = image
        }
    }
    
   
    
    func setArtistName(_ text: String) {
        self.singLabel.text = text
    }
    
    func setCollection(_ text: String) {
        self.collectionLabel.text = text
    }
  
    
    
    
}
