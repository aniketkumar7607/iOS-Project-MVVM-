//
//  ViewController.swift
//  Assignment
//
//  Created by Aniket Kumar on 14/04/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mediaImagesCollection: UICollectionView!
    private let viewModel = MediaCoverageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view controller
        configureCollectionView()
        
        viewModel.fetchMediaCoverages {
            self.mediaImagesCollection.reloadData()
        }
    }
    
    private func configureCollectionView() {
        mediaImagesCollection.dataSource = self
        mediaImagesCollection.delegate = self
        
        let nib = UINib(nibName: "MediaImageCoverageCell", bundle: nil)
        mediaImagesCollection.register(nib, forCellWithReuseIdentifier: "MediaImageCoverageCell")
        
        if let layout = mediaImagesCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            let spacing: CGFloat = 10
            let totalSpacing = (spacing * 2)
            let cellWidth = (mediaImagesCollection.frame.width - totalSpacing) / 3
            layout.itemSize = CGSize(width: cellWidth, height: 150)
            layout.minimumInteritemSpacing = spacing
            layout.minimumLineSpacing = spacing
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.mediaCoverages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaImageCoverageCell", for: indexPath) as! MediaImageCoverageCell
        
        let mediaCoverage = viewModel.mediaCoverages[indexPath.item]
        cell.configure(with: mediaCoverage)
        return cell
    }
}

