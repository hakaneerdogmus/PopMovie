//
//  UserDefaults.swift
//  PopMovie
//
//  Created by Hakan ERDOĞMUŞ on 7.10.2023.
//

import Foundation


class UserDefault {
    
    static let shared = UserDefault()
    
    private init() {}
    
    let key = "favorite"
    let defaults = UserDefaults.standard
    
    @Published var favorites: [Int] = []
    
    //MARK: Save Data
    func saveData(id: Int) {
        favorites = defaults.array(forKey: key) as? [Int] ?? []
        favorites.append(id)
        defaults.set(favorites, forKey: key)
        defaults.synchronize()
        print(favorites)
    }
    
    //MARK: Get Data
    func getData() {
        if let favorites = defaults.value(forKey: key) {
            print(favorites)
            self.favorites = favorites as! [Int]
        }
    }
    
    //MARK: Delete Data
    func deleteData(id: Int) {

            if(self.favorites.contains(id)) {
                for i in 0...self.favorites.count {
                    if(id == self.favorites[i]) {
                        print(self.favorites[i])
                        if var favoritesAr = self.defaults.array(forKey: self.key) as? [Int]  {
                            print("Data dan çekilen veri: \(favoritesAr)")
                            favoritesAr.remove(at: i)
                            print("Silindikten sonra data: \(favoritesAr)")
                            self.defaults.set(favoritesAr, forKey: self.key)
                            print("Güncellenen data: \(favoritesAr)")
                            self.favorites = favoritesAr
                            return
                        }
                        
                    }
                    print("Delete Data")
                }
            }
            else {
                print("No data")
            }
    }
    
    
    //MARK: Delete All Data
    func allRemoveData() {
        defaults.removeObject(forKey: key)
        defaults.synchronize()
        print("Tümü temizlendi")
        favorites.removeAll()
        print(favorites)
    }
    
  
}
