//
//  MoveTableViewController.swift
//  movies
//
//  Created by Michelle Lim on 8/19/17.
//  Copyright © 2017 railsbridge. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    var movies: Array<Movie> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Some Cool Movies!"
        
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=b827e898d3169afcf35ddca35ccd394c")!
        
        let sessionTask = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            switch httpResponse.statusCode {
            case 200:
                if let movieJson = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                    
                    if let results = movieJson!["results"] as? [[String:Any]] {
                        for case let movieHash in results {
                            let posterPath = movieHash["poster_path"] as! String
                            
                            let movie = Movie(
                                title: movieHash["title"] as! String,
                                description: movieHash["overview"] as! String,
                                posterURL: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)?api_key=b827e898d3169afcf35ddca35ccd394c")!
                            )
                            self.movies.append(movie)
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                } else {
                    print("bad json!")
                }
            default:
                print("bad response!")
            }
        })
        sessionTask.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        let movie = self.movies[indexPath.row]
        
        cell.titleLabel.text = movie.title
        cell.descriptionLabel.text = movie.description
        cell.posterImage.image = nil
        
        cell.posterURL = movie.posterURL
        
        downloadImageForCell(imageUrl: movie.posterURL, cell: cell)
        
        return cell
    }
    
    func downloadImageForCell(imageUrl: URL, cell: MovieTableViewCell) {
        let sessionTask = URLSession.shared.dataTask(with: imageUrl, completionHandler: {
            (data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            
            switch httpResponse.statusCode {
            case 200:
                let image = UIImage(data: data!)!
                
                if cell.posterURL == imageUrl {
                    DispatchQueue.main.async {
                        cell.posterImage.image = image
                    }
                }
            default:
                print("not 200!")
            }
        })
    
        sessionTask.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieDetailVC = segue.destination as? MovieDetailViewController {
            movieDetailVC.movie = movies[self.tableView.indexPathForSelectedRow!.row]
            
        }
    }
}
