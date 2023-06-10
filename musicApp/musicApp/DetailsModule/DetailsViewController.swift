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
    func setButtonImage(_ image: UIImage)
}



class DetailsViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var singLabel: UILabel!
    
    @IBOutlet weak var collectionLabel: UILabel!
    
    
    @IBOutlet weak var songImage: UIImageView!
    
    
    @IBOutlet weak var songName: UILabel!
    
    @IBOutlet weak var songPriceLabel: UILabel!
    
    
    @IBOutlet weak var collectionPriceLabel: UILabel!
    
    @IBOutlet weak var typeOfSong: UILabel!
    
    
    @IBOutlet weak var playButton: UIButton!
    
    var timeObserverToken: Any?
    var player: AVPlayer?
    var presenter: DetailsPresenterProtocol!
    var audioPlayer: AVAudioPlayer?
    var isPlaying = false
   

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
//        guard let songURLString = presenter.getSource()?.previewUrl,
//                      let songURL = URL(string: songURLString) else {
//                    return
//                }
//
//                let playerItem = AVPlayerItem(url: songURL)
//                player = AVPlayer(playerItem: playerItem)
//                player?.play()
//
//
//  }
        if isPlaying {
                   presenter.pauseAudio()
               } else {
                   presenter.playAudio()
               }
  
  }
    
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        
        
    }
    
    
    
    }
    
extension DetailsViewController: DetailsViewControllerProtocol {
    func setButtonImage(_ image: UIImage) {
        self.playButton.setImage(image, for: .normal)
    }
    
    
    
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
