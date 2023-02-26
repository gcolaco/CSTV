//
//  NetworkManager.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

class NetworkManager {
    
    static let shared       = NetworkManager()
    private let baseURL     = "https://api.pandascore.co/csgo/"
    private let token       = "iMSx4P6nUTsxypzIkomcghBoYwvKudXtZuSOLFzL4f-W9DoCzSU"
    let cache               = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getUpcomingMatches(page: Int, completion: @escaping (Result<[Matches], CSTVError>) -> Void) {
        let endPoint = baseURL + "matches/upcoming?sort=&page=\(page)&per_page=10&token=\(token)"
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.unableToComplete))
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let matches = try decoder.decode([Matches].self, from: data)
                completion(.success(matches))
            } catch {
                completion(.failure(.invalidData))
            }
            
            
        }
        
        task.resume()
    }
    
    func getRunningMatches(completion: @escaping (Result<[Matches], CSTVError>) -> Void) {
        let endPoint = baseURL + "matches/running?token=\(token)"
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.unableToComplete))
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let matches = try decoder.decode([Matches].self, from: data)
                completion(.success(matches))
            } catch {
                completion(.failure(.invalidData))
            }
            
            
        }
        
        task.resume()
    }
    
    func getPlayersInfo(for slug: String, completion: @escaping (Result<[Teams], CSTVError>) -> Void){
        let endPoint = baseURL + "teams?filter[slug]=\(slug)&token=\(token)"
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.unableToComplete))
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let teams = try decoder.decode([Teams].self, from: data)
                completion(.success(teams))
            } catch {
                completion(.failure(.invalidData))
            }
            
            
        }
        
        task.resume()
    }
  
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                    completion(nil)
                    return
            }

            self.cache.setObject(image, forKey: cacheKey)
            
            completion(image)
        }
        
        task.resume()
    }
}
