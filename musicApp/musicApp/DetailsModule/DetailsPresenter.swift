//
//  DetailsPresenter.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

import Foundation
import musicAPI
import SDWebImage
import AVFoundation

protocol DetailsPresenterProtocol {
    func viewDidLoad()
    func getSource() -> Song?
    var source: Song? { get set }
    func playAudio()
    func pauseAudio()
}

final class DetailsPresenter {
    private var artistViewURL: String?
    var source: Song?
    private var artworkURL: String?
    unowned var view: DetailsViewControllerProtocol!
    let router: DetailsRouterProtocol!
    private var player: AVPlayer?
    private var isPlaying = false
    
    init(
        view: DetailsViewControllerProtocol,
        router: DetailsRouterProtocol
    ) {
        self.view = view
        self.router = router
    }
    func updateArtworkURL() {
        artworkURL = source?.artworkUrl100 ?? ""
    }
    func updateArtistViewURL() {
        artistViewURL = source?.artistViewUrl ?? ""
    }
    
}

extension DetailsPresenter: DetailsPresenterProtocol {
    func playAudio() {
        guard let previewUrlString = source?.previewUrl,
              let previewUrl = URL(string: previewUrlString) else {
            return
        }
        
        if isPlaying {
            pauseAudio()
        } else {
            player = AVPlayer(url: previewUrl)
            player?.play()
            isPlaying = true
            view?.setButtonImage(UIImage(systemName: "pause.fill")!)
            
            
            NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        }
    }
    
    @objc func playerDidFinishPlaying() {
        pauseAudio()
    }
    
    func pauseAudio() {
        player?.pause()
        isPlaying = false
        view?.setButtonImage(UIImage(systemName: "play.fill")!)
    }
    
    func viewDidLoad() {
        
        guard let details = getSource() else { return }
        
        updateArtworkURL()
        
        if let artworkURL = artworkURL, let url = URL(string: artworkURL) {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    print("Image download error: \(error.localizedDescription)")
                } else if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.view?.setArtistImage(image)
                    }
                }
            }.resume()
        }
        
        
        view.setArtistName(details.artistName ?? "")
        view.setCollection(details.collectionName ?? "")
        view.setSongName(details.trackName ?? "" )
        view.setSongType(details.primaryGenreName ?? "")
        if let trackPrice = details.trackPrice {
            let priceString = String(trackPrice)
            view.setSongPrice(priceString)
        } else {
            view.setSongPrice("")
        }
        
        if let collectionPrice = details.collectionPrice {
            let priceString = String(format: "%.2f", collectionPrice)
            view.setCollectionPrice(priceString)
        } else {
            view.setCollectionPrice("")
        }
        
    }
    func getSource() -> Song? {
        return source
    }
    
}
