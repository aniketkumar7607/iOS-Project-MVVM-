//
//  NetworkManager.swift
//  Assignment
//
//  Created by Aniket Kumar on 14/04/24.
//

import Foundation

class NetworkManager {
    
    var apiString :String = "https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=100"
    
    func fetchMediaCoverages(completion: @escaping (Result<[MediaCoverageModel], Error>) -> Void){
        
        let url = URL(string: apiString)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                return
            }
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
            do {
                let decoder = JSONDecoder()
                let mediaCoverages = try decoder.decode([MediaCoverageModel].self, from: data)
                completion(.success(mediaCoverages))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
