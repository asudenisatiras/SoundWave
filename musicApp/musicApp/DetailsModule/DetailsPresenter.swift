//
//  DetailsPresenter.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

import Foundation
import musicAPI
import SDWebImage

protocol DetailsPresenterProtocol {
    func viewDidLoad()
    func getSource() -> Song?
    var source: Song? { get set }
   
}

final class DetailsPresenter {
    private var artistViewURL: String?
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
    func updateArtworkURL() {
          artworkURL = source?.artworkUrl100 ?? ""
      }
    func updateArtistViewURL() {
        artistViewURL = source?.artistViewUrl ?? ""
        }
 
   
}
extension DetailsPresenter: DetailsPresenterProtocol {

    
    func viewDidLoad() {
    
        guard let details = getSource() else { return }
      
        updateArtworkURL()

//                if let artworkURL = artworkURL, let url = URL(string: artworkURL) {
//                    SDWebImageManager.shared.loadImage(with: url, options: .continueInBackground, progress: nil) { [weak self] (image, _, error, _, _, _) in
//                        if let error = error {
//                            print("Image download error: \(error.localizedDescription)")
//                        } else if let image = image {
//                            self?.view?.setArtistImage(image)
//                        }
//                    }
//                }
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
