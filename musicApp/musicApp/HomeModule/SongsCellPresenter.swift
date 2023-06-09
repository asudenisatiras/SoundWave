//
//  SongsCellPresenter.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

import Foundation
import UIKit
import musicAPI


protocol SongsCellPresenterProtocol: AnyObject {
    func load()
   // func togglePlayback()
 //   func pause()
 //   static func stopCurrentPlayback()
}

final class SongsCellPresenter {

    weak var view: SongsCellProtocol?
    private let songs: Song
 //   private let artworkURL: String
//    private var audioPlayer: AVPlayer?
//    private var isPlaying = false
//    static var currentPlayingCell: SongsCell?


    init(
        view: SongsCellProtocol?,
         songs: Song
    ){
        self.view = view
        self.songs = songs
      //  self.artworkURL = songs.artworkUrl100 ?? ""
    }
}

extension SongsCellPresenter: SongsCellPresenterProtocol {
    
    
    func load() {
        
        
        view?.setArtistName(songs.artistName ?? "")
        view?.setCollectionName(songs.collectionName ?? "")
        
        
    }
}
//    func togglePlayback() {
//        if let currentPlayingCell = SongsCellPresenter.currentPlayingCell {
//            // Eğer başka bir hücrede ses çalınıyorsa, çalmayı durdur
//            if currentPlayingCell != view as? SongsCell {
//                currentPlayingCell.cellPresenter.pause()
//            }
//        }
//
//        if isPlaying {
//            pause()
//        } else {
//            play()
//        }
//
//        SongsCellPresenter.currentPlayingCell = view as? SongsCell // Şu anki hücreyi çalan hücre olarak belirle
//
//        updateButtonImage()
//    }
//        private func play() {
//            guard let previewURLString = songs.previewUrl,
//                let previewURL = URL(string: previewURLString) else {
//                    return
//            }
//
//            if audioPlayer == nil {
//                let playerItem = AVPlayerItem(url: previewURL)
//                audioPlayer = AVPlayer(playerItem: playerItem)
//            }
//
//            audioPlayer?.play()
//            isPlaying = true
//        }
//
//      func pause() {
//            audioPlayer?.pause()
//            isPlaying = false
//          DispatchQueue.main.async { [weak self] in
//                self?.view?.setButtonImage(UIImage(systemName: "play.circle"))
//            }
//        }
//
//        private func updateButtonImage() {
//            DispatchQueue.main.async { [weak self] in
//                guard let self = self else { return }
//                if self.isPlaying {
//                    self.view?.setButtonImage(UIImage(systemName: "pause.circle"))
//                } else {
//                    self.view?.setButtonImage(UIImage(systemName: "play.circle"))
//                }
//            }
//        }
//  }

