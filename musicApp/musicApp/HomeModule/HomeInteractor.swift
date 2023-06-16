//
//  HomeInteractor.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

import Foundation
import musicAPI

typealias SongsSourcesResult = Result<[Song], Error>

protocol HomeInteractorProtocol: AnyObject {
    func fetchSearchSongs(_ word: String)
}

protocol HomeInteractorOutput: AnyObject {
    
    func fetchSongsOutput(_ result: SongsSourcesResult)
}

var service: SongsServiceProtocol = MusicService()

class HomeInteractor {
    weak var output: HomeInteractorOutput?
    let musicService = MusicService()
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func fetchSearchSongs(_ word: String) {
        musicService.searchSongs(wordName: word) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchSongsOutput(result)
            
        }
        
    }
    
}
