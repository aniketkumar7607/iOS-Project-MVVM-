//
//  MediaCoverageViewModel.swift
//  Assignment
//
//  Created by Aniket Kumar on 14/04/24.
//

import Foundation
import UIKit

class MediaCoverageViewModel {
    private let networkManager = NetworkManager()
    private let fileManager = FileManager.default
    private lazy var cacheDirectory: URL = {
        return fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }()
    
    var mediaCoverages: [MediaCoverageModel] = []
    
    func fetchMediaCoverages(completion: @escaping () -> Void) {
        networkManager.fetchMediaCoverages { [weak self] result in
            switch result {
            case .success(let mediaCoverages):
                self?.mediaCoverages = mediaCoverages
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let error):
                print("Error fetching media coverages:", error.localizedDescription)
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}
