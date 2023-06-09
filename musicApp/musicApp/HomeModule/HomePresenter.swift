//
//  HomePresenter.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

import Foundation
import musicAPI


protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    var numberOfItems: Int { get }
    func song(_ index: Int) -> Song?
    func fetchSongs(_ word: String)
   func didSelectRowAt(index: Int)
}

class HomePresenter {
    var songs: [Song] = []
    unowned var view: HomeViewControllerProtocol
    let router: HomeRouterProtocol!
    var interactor: HomeInteractorProtocol!
    
    
    init(
        view: HomeViewControllerProtocol,
        router: HomeRouterProtocol,
        interactor: HomeInteractorProtocol
       
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        
    }
    
}
extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        view.setupTableView()
        
    }
    
    func didSelectRowAt(index: Int) {
        guard let source = song(index) else { return }
        router.navigate(.detail(source: source))
    }
    

    func fetchSongs(_ word: String) {
        view.showLoadingView()
        interactor.fetchSearchSongs(word)
    }

    
    func song(_ index: Int) -> Song? {
        return songs[safe: index]
    }
    
    var numberOfItems: Int {
        songs.count
    }
    
  

}
extension HomePresenter: HomeInteractorOutput {
    func fetchSongsOutput(_ result: SongsSourcesResult) {
        view.hideLoadingView()
        switch result {
        case .success(let songs):
            self.songs = songs
            view.reloadData()
        case .failure(let error):
            view.showError(error.localizedDescription)
        }
    }
}
//import UIKit
//import musicAPI
//
//protocol HomePresenterProtocol: AnyObject {
//
//    func searchButtonTapped(with keyword: String)
//    var numberOfItems: Int { get }
//    func songs(_ index: Int) -> Song?
//    func load()
//}
//
//final class HomePresenter: HomePresenterProtocol, HomeInteractorOutputProtocol {
//
//    private var songs: [Song] = []
//    weak var view: HomeViewProtocol?
//    var interactor: HomeInteractorProtocol
//    var router: HomeRouterProtocol
//
//    init(interactor: HomeInteractorProtocol, router: HomeRouterProtocol, view: HomeViewProtocol) {
//        self.interactor = interactor
//        self.router = router
//        self.view = view
//    }
//
//    func load() {
//        interactor.fetchSongs(with: "")
//    }
//
//
//    func searchButtonTapped(with keyword: String) {
//            interactor.fetchSongs(with: keyword)
//        }
//
//    func songsFetchedSuccessfully(_ songs: [Song]) {
//        self.songs = songs
//        view?.reloadTableView()
//    }
////
//        func songsFetchFailed(with error: Error) {
//            view?.showError(message: error.localizedDescription)
//        }
//    var numberOfItems: Int {
//        songs.count
//    }
//
//    func songs(_ index: Int) -> Song? {
//          guard index >= 0 && index < songs.count else {
//              return nil
//          }
//          return songs[index]
//      }
//}
