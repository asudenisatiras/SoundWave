//
//  SongsCellPresenter.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

import Foundation
import UIKit
import musicAPI
import SDWebImage
import AVFoundation

protocol SongsCellPresenterProtocol: AnyObject {
    func load()
    func playButtonTapped()

   
}

final class SongsCellPresenter {
    private let artworkURL: String
    weak var view: SongsCellProtocol?
    private let songs: Song
    private let previewURL: String
    private var audioPlayer: AVPlayer?
    private var playerItem: AVPlayerItem?

    private var isPlaying = false

    init(
        view: SongsCellProtocol?,
         songs: Song
    ){
        self.view = view
        self.songs = songs
      //  self.artworkURL = songs.artworkUrl100 ?? ""
        self.artworkURL = songs.artworkUrl100 ?? ""
        self.previewURL = songs.previewUrl ?? ""
    }
    private func playAudio() {
            audioPlayer?.play()
            isPlaying = true
        }

        private func stopAudio() {
            audioPlayer?.pause()
            isPlaying = false
        }
}

extension SongsCellPresenter: SongsCellPresenterProtocol {
    
    
    func load() {
        if let url = URL(string: artworkURL) {
            SDWebImageManager.shared.loadImage(with: url, options: .continueInBackground, progress: nil) { [weak self] (image, _, error, _, _, _) in
                if let error = error {
                    print("Image download error: \(error.localizedDescription)")
                } else if let image = image {
                    self?.view?.setImage(image)
                }
            }
        }
        view?.setArtistName(songs.artistName ?? "")
        view?.setCollectionName(songs.collectionName ?? "")
        view?.setSongName(songs.trackName ?? "")
        
    }
    func playButtonTapped() {
        if isPlaying {
            stopAudio()
        } else {
            if let previewURL = URL(string: previewURL) {
                playerItem = AVPlayerItem(url: previewURL)
                audioPlayer = AVPlayer(playerItem: playerItem)
                playAudio()
            }
        }
    }
    
}