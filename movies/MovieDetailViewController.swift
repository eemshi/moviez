//
//  MovieDetailViewController.swift
//  movies
//
//  Created by Michelle Lim on 8/19/17.
//  Copyright © 2017 railsbridge. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = movie?.title
        self.descriptionLabel.text = movie?.description
        self.titleLabel.text = movie?.title
    }
}
