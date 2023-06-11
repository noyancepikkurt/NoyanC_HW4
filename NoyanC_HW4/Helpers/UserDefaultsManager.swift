//
//  UserDefaultsManager.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 11.06.2023.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let lastSearchKey = "LastSearchKey"
    
    func saveLastSearchText(_ searchText: String) {
            UserDefaults.standard.set(searchText, forKey: lastSearchKey)
        }
        
        func getLastSearchText() -> String? {
            return UserDefaults.standard.string(forKey: lastSearchKey)
        }
}
