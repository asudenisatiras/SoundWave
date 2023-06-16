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
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.isTranslucent = true
            searchBar.searchTextField.accessibilityIdentifier = "searchBar"
            tableView.accessibilityIdentifier = "tableView"
            presenter?.viewDidLoad()
            if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
                
                searchTextField.borderStyle = .none
                searchTextField.font = UIFont.systemFont(ofSize: 14)
                
                searchTextField.layer.cornerRadius = 12
                searchTextField.layer.borderWidth = 0.3
                searchTextField.layer.borderColor = UIColor.lightGray.cgColor
                searchTextField.layer.shadowColor = UIColor.lightGray.cgColor
                searchTextField.layer.shadowOpacity = 0.8
                searchTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
                searchTextField.layer.shadowRadius = 8

            }
                   
        }
        searchBar.delegate = self
    }
   
    func stopPlayingMusic() {
        if let visibleCells = tableView.visibleCells as? [Musics] {
            for cell in visibleCells {
                cell.cellPresenter.stopAudio()
                cell.cellPresenter.updateButtonImage()
            }
           
        }
    }
}
extension HomeViewController: HomeViewControllerProtocol {
func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(cellType: Musics.self)

    let backgroundView = UIView(frame: tableView.bounds)
       
       let titleLabel = UILabel()
       titleLabel.text = "Always Discover Something"
       titleLabel.textAlignment = .center
       titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    titleLabel.textColor = .systemPurple
       
       let subtitleLabel = UILabel()
       subtitleLabel.text = "Song, Artist, and More"
       subtitleLabel.textAlignment = .center
       subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
       subtitleLabel.textColor = .black
       
       backgroundView.addSubview(titleLabel)
       backgroundView.addSubview(subtitleLabel)
    
       titleLabel.translatesAutoresizingMaskIntoConstraints = false
       subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
       
       NSLayoutConstraint.activate([
           titleLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
           titleLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
           subtitleLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
           subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
       ])
       
       tableView.backgroundView = backgroundView
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

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text?.removeDiacritics().uppercased() {
            presenter?.fetchSongs(searchTerm)
        }

        searchBar.resignFirstResponder()
    }
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           if searchText.isEmpty {
               presenter?.fetchSongs("")
               reloadData()
           }
       }
}

extension String {
    func removeDiacritics() -> String {
        let foldingOptions = NSString.CompareOptions.diacriticInsensitive
        let locale = Locale.current
        return self.folding(options: foldingOptions, locale: locale)
    }
}
