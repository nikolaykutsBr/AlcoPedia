//
//  RecipeViewController.swift
//  AlcoPedia
//
//  Created by Mikalai Kuts on 1/12/21.
//  Copyright © 2021 Mikalai Kuts. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    
    private let identifierForCocktail = "ShowRecipe"
    var recipeName: String = ""
    var imageName: UIImage = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Recipe of \(recipeName)"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        
        setImageAndName(name: recipeName, name: imageName)
        self.view.backgroundColor = .white
        
    }
    
    

    private func setImageAndName(name: String, name image : UIImage){
        let imageOfRecipe = UIImageView(image: image)
        let nameOfRecipe = UILabel()
        nameOfRecipe.frame = CGRect(x: 20, y: 80, width: 500, height: 100)
        nameOfRecipe.text = name
        imageOfRecipe.frame = CGRect(x: 20, y: 150, width: 120, height: 250)
        self.view.addSubview(imageOfRecipe)
        self.view.addSubview(nameOfRecipe)
    }
    

}
