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
