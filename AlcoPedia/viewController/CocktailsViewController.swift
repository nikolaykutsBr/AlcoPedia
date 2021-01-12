//
//  CocktailsViewController.swift
//  AlcoPedia
//
//  Created by Mikalai Kuts on 12/29/20.
//  Copyright © 2020 Mikalai Kuts. All rights reserved.
//

import UIKit

class CocktailsViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource {

    
    let recipeViewController: RecipeViewController = RecipeViewController()
    var tableView =  UITableView()
    let identifier = "MyCell"
    let imagesOfCocktails: [UIImage] =  [UIImage(named: "royal_shot")!,UIImage(named: "jellyfish")!,UIImage(named: "vodka_with_redbull")!,UIImage(named: "god_bless_america")!,UIImage(named: "bitter_pills")!,UIImage(named: "bird_shit")!]
    let namesOfCocktails: [String] =  ["Royal Shot","Jellyfish","Vodka with Redbull","God Bless America","Bitter Pills","Bird Shit"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Cockatils"
        
        createTableView()
        
      
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

   
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
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
        
    }


    func createTableView() {
        
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        self.tableView.delegate = self as? UITableViewDelegate
        self.tableView.dataSource = self
        self.tableView.rowHeight = 150.0
        
        view.addSubview(tableView)
        
    }
    
    
    
    
}
