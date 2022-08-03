//
//  CareTaker.swift
//  Millionaire
//
//  Created by Елена Иванкина on 11.07.2021.
//

import Foundation

class CareTaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "key"
    
    func saveResults(results: [Int]) {
        do {
            let data = try encoder.encode(results)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadResults() -> [Int]? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        
        do {
            return try decoder.decode([Int].self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
