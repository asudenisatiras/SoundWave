//
//  Musics.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//
import UIKit


protocol SongsCellProtocol: AnyObject {
    func setImage(_ image: UIImage)
    func setSongName(_ text: String)
    func setSingerName(_ text: String)
    func setCollectionName(_ text: String)
    func setButtonImage(_ image: UIImage?)
}
class Musics: UITableViewCell {
    
    @IBOutlet weak var songsImage: UIImageView!
    
    @IBOutlet weak var songNameLabel: UILabel!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    
    
    @IBOutlet weak var collectionNameLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    
    var cellPresenter: SongsCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.alpha = 0.0
          UIView.animate(withDuration: 0.5) {
              self.alpha = 1.0
          }

        
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

    @IBAction func playSongButton(_ sender: UIButton) {
        cellPresenter.playButtonTapped()

    }
}

extension Musics: SongsCellProtocol {

    func setButtonImage(_ image: UIImage?) {
        
              DispatchQueue.main.async {
                  self.playButton.setImage(image, for: .normal)
              }
          }
    
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.songsImage.image = image
        }
    }

        func setSingerName(_ text: String) {
            artistNameLabel.text = text
        }

        func setCollectionName(_ text: String) {
            collectionNameLabel.text = text
        }
        func setSongName(_ text: String) {
            songNameLabel.text = text
            
        }

      

    }
    
    
    

//    @objc func playButtonTapped() {
//        guard let song = self.song else { return }
//        guard let previewUrl = song.previewUrl else { return }
//        guard let url = URL(string: previewUrl) else { return }
//
//        if let player = audioPlayer {
//            if player.rate != 0 && player.error == nil {
//                player.pause()
//            } else {
//                let playerItem = AVPlayerItem(url: url)
//                player.replaceCurrentItem(with: playerItem)
//                player.play()
//            }
//        } else {
//            let playerItem = AVPlayerItem(url: url)
//            audioPlayer = AVPlayer(playerItem: playerItem)
//            audioPlayer?.play()
//        }
//    }

        
    
    
 
