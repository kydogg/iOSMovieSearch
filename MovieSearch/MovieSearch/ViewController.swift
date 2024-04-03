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
}

