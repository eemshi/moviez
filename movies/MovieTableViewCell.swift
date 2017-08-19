//
//  MovieTableViewCell.swift
//  movies
//
//  Created by Michelle Lim on 8/19/17.
//  Copyright © 2017 railsbridge. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var posterURL:URL?
}
