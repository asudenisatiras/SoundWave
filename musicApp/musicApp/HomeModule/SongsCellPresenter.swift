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
    func updateButtonImage()
    func stopAudio()
    func playAudio()
}

final class SongsCellPresenter {
    
    private let artworkURL: String
    weak var view: SongsCellProtocol?
    private let songs: Song
    private let previewURL: String
    private var audioPlayer: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var isPlaying = false
    private var isButtonEnabled = true
    private var isCellPlaying = false
    static var isAnyCellPlaying = false
    
    init(
        view: SongsCellProtocol?,
        songs: Song
    ){
        self.view = view
        self.songs = songs
        self.artworkURL = songs.artworkUrl100 ?? ""
        self.previewURL = songs.previewUrl ?? ""
    }

     func playAudio() {
        audioPlayer?.play()
        isPlaying = true
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleAudioPlayerFinished), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: audioPlayer?.currentItem)
    }

    func stopAudio() {
        audioPlayer?.pause()
        isPlaying = false
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: audioPlayer?.currentItem)
    }

  func updateButtonImage() {
        let buttonImage: UIImage?
        if isPlaying {
            buttonImage = UIImage(systemName: "pause.fill")
        } else {
            buttonImage = UIImage(systemName: "play.fill")
        }
        view?.setButtonImage(buttonImage)
    }
    
    @objc private func handleAudioPlayerFinished() {
        stopAudio()
        isCellPlaying = false
        updateButtonImage()
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
        view?.setSingerName(songs.artistName ?? "")
        view?.setCollectionName(songs.collectionName ?? "")
        view?.setSongName(songs.trackName ?? "")
        updateButtonImage()
    }

    func playButtonTapped() {
        if isCellPlaying {
            stopAudio()
            isCellPlaying = false
            updateButtonImage()
            SongsCellPresenter.isAnyCellPlaying = false
        } else {
            if isButtonEnabled && !SongsCellPresenter.isAnyCellPlaying {
                isButtonEnabled = false
                
                if isPlaying {
                    stopAudio()
                } else {
                    if let previewURL = URL(string: previewURL) {
                        playerItem = AVPlayerItem(url: previewURL)
                        audioPlayer = AVPlayer(playerItem: playerItem)
                        playAudio()
                    }
                }
                isCellPlaying = true
                updateButtonImage()
                SongsCellPresenter.isAnyCellPlaying = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                    self?.isButtonEnabled = true
                }
            }
        }
    }
}
