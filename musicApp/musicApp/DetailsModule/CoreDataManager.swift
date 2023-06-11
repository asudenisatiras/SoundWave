//
//  CoreDataManager.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 11.06.2023.
//


import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    func saveAudioData(trackId: Int64, artistName: String, trackName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let newSong = NSEntityDescription.insertNewObject(forEntityName: "FavoriteSong", into: context)
        newSong.setValue(trackId, forKey: "trackid")
        newSong.setValue(artistName, forKey: "artistName")
        newSong.setValue(trackName, forKey: "trackName")
        do {
            try context.save()
           // print("Veri kaydedildi. Track ID: \(trackId), Artist Name: \(artistName), Track Name: \(trackName)")
        } catch {
            print("Kayıt başarısız")
        }
    }
    func deleteAudioData(withTrackId trackId: Int64) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteSong")
        fetchRequest.predicate = NSPredicate(format: "trackid == %d", trackId)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let favoriAudios = results as? [NSManagedObject], let favoriAudio = favoriAudios.first {
                context.delete(favoriAudio)
                try context.save()
                print("Veri silindi. Track ID: \(trackId)")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func isTrackIdSaved(_ trackId: Int64) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteSong")
        fetchRequest.predicate = NSPredicate(format: "trackid == %d", trackId)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.count > 0
        } catch {
            print(error.localizedDescription)
        }
        
        return false
    }
    func isTrackIdSaved(_ trackId: Int) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteSong")
        fetchRequest.predicate = NSPredicate(format: "trackid == %d", trackId)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.count > 0
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    func fetchAudioData() -> [Int] {
        var trackIds: [Int] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return trackIds }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteSong")
        
        do {
            let results = try context.fetch(fetchRequest)
            if let favoriAudios = results as? [NSManagedObject] {
                for favoriAudio in favoriAudios {
                    if let trackId = favoriAudio.value(forKey: "trackid") as? Int {
                        trackIds.append(trackId)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return trackIds
    }
}
