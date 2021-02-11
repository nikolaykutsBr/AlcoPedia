//
//  CocktailsViewController.swift
//  AlcoPedia
//
//  Created by Mikalai Kuts on 12/29/20.
//  Copyright © 2020 Mikalai Kuts. All rights reserved.
//

import UIKit

class CocktailsViewController: UIViewController, UITableViewDelegate, UIScrollViewDelegate, UITableViewDataSource {

    
    private let recipeViewController: RecipeViewController = RecipeViewController()
    private let imagesOfCocktails: [UIImage] =  [UIImage(named: "royal_shot")!,UIImage(named: "jellyfish")!,UIImage(named: "vodka_with_redbull")!,UIImage(named: "god_bless_america")!,UIImage(named: "bitter_pills")!,UIImage(named: "bird_shit")!]
    private let namesOfCocktails: [String] =  ["Royal Shot","Jellyfish","Vodka with Redbull","God Bless America","Bitter Pills","Bird Shit"]
    private let identifier = "MyCell"
    private var tableView =  UITableView()
    private var searchResult: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Cocktails"
        self.navigationItem.title = "Cocktails"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationItem.searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController?.isActive = true
        self.navigationItem.searchController?.hidesNavigationBarDuringPresentation = false

        createTableView()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesOfCocktails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        cell.imageView?.image = imagesOfCocktails[indexPath.row]
        cell.textLabel?.text = namesOfCocktails[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let recipeViewController = storyboard.instantiateViewController(withIdentifier: "RecipeViewController") as? RecipeViewController else { return }
        recipeViewController.recipeName = namesOfCocktails[indexPath.row]
        recipeViewController.imageName = imagesOfCocktails[indexPath.row]
        show(recipeViewController, sender: nil)
    }

    private func createTableView() {
        
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 150.0
        
        view.addSubview(tableView)
        
    }
    
    private func setUpSearchBar(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.isActive = true
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private func filterContent(for searchText: String) {
        searchResult = namesOfCocktails.filter({ (title: String) -> Bool in
            let match = title.range(of: searchText, options: .caseInsensitive)
            return match != nil
        })
    }
    
    private func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    
}
