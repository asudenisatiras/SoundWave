//
//  HomeViewController.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

import UIKit


protocol HomeViewControllerProtocol: AnyObject {
    func setupTableView()
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func showError(_ message: String)
}

class HomeViewController: BaseViewController  {
  
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var searchBar: UISearchBar!

var presenter: HomePresenterProtocol!
    
    
    var isSearchBarEmpty: Bool {
        return searchBar.text?.isEmpty ?? true
    }

override func viewDidLoad() {
    super.viewDidLoad()
    
    presenter?.viewDidLoad()
 
}
}

extension HomeViewController: HomeViewControllerProtocol {
func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(cellType: Musics.self)
    let backgroundImageView = UIImageView(image: UIImage(named: "song"))
    backgroundImageView.contentMode = .scaleAspectFit
    let scaleFactor: CGFloat = 0.8 
    let scaledWidth = tableView.frame.width * scaleFactor
    let scaledHeight = tableView.frame.height * scaleFactor
    let offsetX = (tableView.frame.width - scaledWidth) / 4
    let offsetY = (tableView.frame.height - scaledHeight) / 4
    backgroundImageView.frame = CGRect(x: offsetX, y: offsetY, width: scaledWidth, height: scaledHeight)
    tableView.backgroundView = backgroundImageView
    tableView.backgroundView?.isHidden = !isSearchBarEmpty

}
func reloadData() {
    DispatchQueue.main.async { [weak self] in
        guard let self else { return }
        self.tableView.reloadData()
        self.tableView.backgroundView?.isHidden = !self.isSearchBarEmpty
    }
}

func showError(_ message: String) {
    showAlert("Error", message)
}

func showLoadingView() {
    showLoading()
}

func hideLoadingView() {
    hideLoading()

}

}
extension HomeViewController: UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.numberOfItems ?? 10
}


func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    tableView.separatorStyle = .none
    let cell = tableView.dequeueReusableCell(with: Musics.self, for: indexPath)
    
    
    if let songs = presenter?.song(indexPath.row) {
        cell.cellPresenter = SongsCellPresenter(view: cell, songs: songs)
    }
    return cell
}

}
extension HomeViewController: UITableViewDelegate {

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
    presenter.didSelectRowAt(index: indexPath.row)
}

func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 130
}

}

//extension HomeViewController: UISearchBarDelegate {
//func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//    if let searchTerm = searchBar.text?.removingTurkishDiacritics().uppercased() {
//        presenter?.fetchSongs(searchTerm)
//    }
//
//    searchBar.resignFirstResponder()
//}
//}
//extension String {
//func removingTurkishDiacritics() -> String {
//    return self.folding(options: .diacriticInsensitive, locale: .current)
//}
//}
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text?.removeDiacritics().uppercased() {
            presenter?.fetchSongs(searchTerm)
        }
        
        searchBar.resignFirstResponder()
    }
}

extension String {
    func removeDiacritics() -> String {
        let foldingOptions = NSString.CompareOptions.diacriticInsensitive
        let locale = Locale.current
        return self.folding(options: foldingOptions, locale: locale)
    }
}
