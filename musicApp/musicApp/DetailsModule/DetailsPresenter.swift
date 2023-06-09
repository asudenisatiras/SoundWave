//
//  DetailsPresenter.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

import Foundation
import musicAPI


protocol DetailsPresenterProtocol {
    func viewDidLoad()
    func getSource() -> Song?
    var source: Song? { get set }
}

final class DetailsPresenter {
    
    var source: Song?
    private var artworkURL: String?
    unowned var view: DetailsViewControllerProtocol!
    let router: DetailsRouterProtocol!
    
    init(
        view: DetailsViewControllerProtocol,
        router: DetailsRouterProtocol
    ) {
        self.view = view
        self.router = router
    }
   
}
extension DetailsPresenter: DetailsPresenterProtocol {

    
    func viewDidLoad() {
    
        guard let details = getSource() else { return }
      
        
        view.setArtistName(details.artistName ?? "")
        view.setCollection(details.collectionName ?? "")
        
    }
    func getSource() -> Song? {
        return source
    }
    
}
