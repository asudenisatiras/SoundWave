//
//  DetailsViewController.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

import UIKit
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
    
    
    @IBOutlet weak var likedButton: UIButton!
    
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    var timeObserverToken: Any?
    var player: AVPlayer?
    var presenter: DetailsPresenterProtocol!
    var audioPlayer: AVAudioPlayer?
    var isPlaying = false
    let coreDataManager = CoreDataManager.shared
    var displayLink: CADisplayLink?
    deinit {
        player?.removeObserver(self, forKeyPath: "status")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.accessibilityIdentifier = "playButton"
        likedButton.accessibilityIdentifier = "likedButton"
        presenter.viewDidLoad()
        updateLikeButtonImage()
        navigationController?.navigationBar.tintColor = .white
        if let player = player {
            let interval = CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
            timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
                self?.updateProgressView()
            }
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           
           
           presenter.pauseAudio()
           stopProgressViewAnimation()
           player?.pause()
           isPlaying = false
       }
    func updateLikeButtonImage() {
        guard let trackId = presenter.getSource()?.trackId else {
            return
        }
        
        let heartImageName = coreDataManager.isTrackIdSaved(trackId) ? "heart.fill" : "heart"
        if let heartImage = UIImage(systemName: heartImageName) {
            likedButton.setImage(heartImage, for: .normal)
        }
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
//
//        if isPlaying {
//                   presenter.pauseAudio()
//               } else {
//                   presenter.playAudio()
//               }
        if isPlaying {
              presenter.pauseAudio()
              stopProgressViewAnimation()
              player?.pause()
              player?.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
              isPlaying = false
          } else {
              if player == nil {
                  guard let audioUrlString = presenter.getSource()?.previewUrl,
                        let audioUrl = URL(string: audioUrlString) else {
                      return
                  }
                  
                  let playerItem = AVPlayerItem(url: audioUrl)
                  player = AVPlayer(playerItem: playerItem)
                  player?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
                  
                  // Kullanıcı bir kere çal düğmesine bastığında, şarkının tamamen çalmasını beklemek için bir gözlemci ekleyin.
                  NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
              }
              
              player?.play()
              isPlaying = true
              startProgressViewAnimation()
          }
          
          // Butonun görüntüsünü güncelle
          updatePlayButtonImage()
          
          // Butonun etkinliğini devre dışı bırak
          sender.isEnabled = false
          
          // Belirli bir süre sonra butonun etkinliğini tekrar etkinleştir
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
              sender.isEnabled = true
          }
      }

      func updatePlayButtonImage() {
          let buttonImageName = isPlaying ? "pause.fill" : "play.fill"
          if let buttonImage = UIImage(systemName: buttonImageName) {
              playButton.setImage(buttonImage, for: .normal)
          }
      
  
  }
    @objc func playerDidFinishPlaying(notification: NSNotification) {
        presenter.pauseAudio()
        stopProgressViewAnimation()
        player?.pause()
        player?.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
        isPlaying = false
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status", let player = object as? AVPlayer, player == self.player {
            if let status = change?[.newKey] as? Int, status == AVPlayer.Status.readyToPlay.rawValue {
                // AVPlayer hazır durumda, ilerleme çubuğunu güncelleme işlemlerini burada gerçekleştirin
            }
        }
    }

    private func startProgressViewAnimation() {
        progressView.setProgress(0.0, animated: false)
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: #selector(updateProgressView))
            displayLink?.add(to: .main, forMode: .common)
        }
    }

    private func stopProgressViewAnimation() {
        displayLink?.invalidate()
        displayLink = nil
        progressView.setProgress(0.0, animated: false)
    }


    @objc private func updateProgressView() {
        guard let player = player else {
            return
        }
        
        let currentTime = player.currentTime().seconds
        let duration = player.currentItem?.duration.seconds ?? 0.0
        
        if duration > 0 {
            let progress = Float(currentTime / duration)
            progressView.setProgress(progress, animated: true)
        } else {
            progressView.setProgress(0.0, animated: false)
        }
    }
    @IBAction func likeButtonClicked(_ sender: UIButton) {
      
    guard let trackId = presenter.getSource()?.trackId,
                 let artistName = presenter.getSource()?.artistName,
                 let trackName = presenter.getSource()?.trackName else {
               return
           }
           
           if coreDataManager.isTrackIdSaved(trackId) {
               let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to remove this track from your favorites?", preferredStyle: .alert)
               
               let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
               
               let removeAction = UIAlertAction(title: "Remove", style: .destructive) { _ in
                   self.coreDataManager.deleteAudioData(withTrackId: Int64(trackId))
                   print("Data deleted. Track ID: \(trackId)")
                   if let heartImage = UIImage(systemName: "heart") {
                       sender.setImage(heartImage, for: .normal)
                   }
               }
               
               alert.addAction(cancelAction)
               alert.addAction(removeAction)
               
               present(alert, animated: true, completion: nil)
           } else {
               coreDataManager.saveAudioData(trackId: Int64(trackId), artistName: artistName, trackName: trackName)
               print("Data saved. Track ID: \(trackId), Artist Name: \(artistName), Track Name: \(trackName)")
               if let heartImages = UIImage(systemName: "heart.fill") {
                   sender.setImage(heartImages, for: .normal) 
               }
               
               let alert = UIAlertController(title: "Success", message: "Track has been saved to your favorites.", preferredStyle: .alert)
               let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
               alert.addAction(okAction)
               present(alert, animated: true, completion: nil)
           }
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
