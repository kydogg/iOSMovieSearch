//
//  ViewController.swift
//  MovieSearch
//
//  Created by Kyle D. Baker on 4/3/24.
//

import UIKit

// UI: TextField to search for movies
//UIVIew for the rest of the movies
//network request
//tap a cell to see info about the movie
//custom cell to show movie
//

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var movies = [Movie]()
    //making the UI
    
    //first thing to do is to  make the
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!
    
    //assign delegate and data source for the tableView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
    }
    
    //Search Field Functionality
    
    //capture the event when user hits the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovies()
        return true
    }
    
    //search for the movies themselve.
    func searchMovies() {
        //keyboard needs to go away then user taps off the search bar
        textField.resignFirstResponder()
        
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        
        let query = text.replacingOccurrences(of: " ", with: "%20")
        movies.removeAll()
        
        
//    https://www.omdbapi.com/?i=tt3896198&apikey=ff9cfdd5
        URLSession.shared.dataTask(with: URL(string:
//                                                TODO: make sure that this link is correct for your network call
                                                "https://omdbapi.com/?apikey=3aea79ac&s=fast%20and&type-movie")!, completionHandler: {
            data, response, error in guard let data = data, error == nil else {
                return
            } //convert the data into the Movie struct
            var result: MovieResults?
            do {
                result = try JSONDecoder().decode(MovieResults.self, from: data)
            } catch {
                print("error")
            }
            
            //validate that the above logic was successful
            guard let finalResult = result else {
                return
            }
            print("\(finalResult.Search.first?.Title)")
            
            //update the movie array
            let newMovies = finalResult.Search
            self.movies.append(contentsOf: newMovies)
            
            //refresh out table
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }).resume()
    }
    
    // TabelView Functionality
    //    I believe these are called closures,
    //    TODO: make sure to google this, is this a closure?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //showMovieDetails
        
    }
    
    struct MovieResults: Codable {
        let Search: [Movie]
    }
    
    struct Movie: Codable {
        let Title: String
        let Year: String
        let imdbID: String
        let _Type: String
        let Poster: String
        
        private enum CodingKeys: String, CodingKey {
            case Title, Year, imdbID, _Type = "Type", Poster
        }
        
    }
}

