//
//  ItemTableViewCell.swift
//  MovieInfo
//
//  Created by Michael Moore on 8/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    var movie: MovieObject? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let movie = movie else {
            titleLabel.text = ""
            summaryLabel.text = ""
            ratingLabel.text = ""
            movieImageView.image = nil
            return
        }
        ratingLabel.text = "\(movie.rating)"
        summaryLabel.text = movie.summary
        titleLabel.text = movie.title
        
        MovieController.fetchImage(image: movie) { (fetchedImage) in
            DispatchQueue.main.async {
                self.movieImageView.image = fetchedImage
            }
        }
        
    }
}
