//
//  HomeInteractor.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

//import musicAPI
//
//protocol HomeInteractorOutputProtocol: AnyObject {
//    func songsFetchedSuccessfully(_ songs: [Song])
//    func songsFetchFailed(with error: Error)
//}
//
//protocol HomeInteractorProtocol: AnyObject {
//    var presenter: HomeInteractorOutputProtocol? { get set }
//    func fetchSongs(with keyword: String)
//}
//
//class HomeInteractor: HomeInteractorProtocol {
//    weak var presenter: HomeInteractorOutputProtocol?
//
//    let musicService = MusicService()
//
//    func fetchSongs(with keyword: String) {
//        musicService.searchSongs(wordName: keyword) { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let songs):
//                self.presenter?.songsFetchedSuccessfully(songs)
//            case .failure(let error):
//                self.presenter?.songsFetchFailed(with: error)
//            }
//        }
//    }
//}
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
