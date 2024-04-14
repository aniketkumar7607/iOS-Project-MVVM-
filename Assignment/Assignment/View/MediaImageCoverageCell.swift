//
//  MediaImageCoverageCell.swift
//  Assignment
//
//  Created by Aniket Kumar on 14/04/24.
//

import UIKit

class MediaImageCoverageCell: UICollectionViewCell {
    @IBOutlet weak var mediaImageView: UIImageView!
    let placeholderImage = UIImage(named: "image_not_found")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mediaImageView.contentMode = .scaleAspectFill
        mediaImageView.clipsToBounds = true
    }
    
    func configure(with mediaCoverage: MediaCoverageModel) {
        if let imageUrl = URL(string: mediaCoverage.coverageURL) {
            mediaImageView.fetchImage(from: imageUrl, placeholder: placeholderImage) { image in
            }
        } else {
            mediaImageView.image = placeholderImage
        }
    }
}

