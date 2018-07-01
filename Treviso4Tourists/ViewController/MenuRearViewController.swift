//
//  MenuRearViewController.swift
//  Treviso4Tourists
//
//  Created by Administrator on 25/06/18.
//  Copyright © 2018 Edoardo Scarpel. All rights reserved.
//

import UIKit

var categories:[String] = ["Best of Week", "Monumenti", "Musei", "Teatro", "Parchi","Ristoranti", "Bar", "Pasticcerie", "Pizzerie", "Gelaterie", "Sushi"]
var categoryIcon:[String] = ["first", "history", "museum", "theater", "park", "restaurant", "bar", "coffee", "pizza", "ice-cream", "sushi"]
var homeTapped:Bool = false

class MenuRearViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var menuSuperview: UIView!
    @IBOutlet weak var CategoriesLabel: UILabel!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if DarkMode {
            self.menuSuperview?.backgroundColor = UIColor(red: 16.0/255.0, green: 30.0/255.0, blue: 41.0/255.0, alpha: 1.0)
            self.CategoriesLabel.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        } else {
            self.menuSuperview?.backgroundColor = UIColor.white
            self.CategoriesLabel.textColor = UIColor.black
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if DarkMode {
            self.menuSuperview?.backgroundColor = UIColor(red: 16.0/255.0, green: 30.0/255.0, blue: 41.0/255.0, alpha: 1.0)
            self.CategoriesLabel.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        } else {
            self.menuSuperview?.backgroundColor = UIColor.white
            self.CategoriesLabel.textColor = UIColor.black
        }
        categoriesCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as! MenuCollectionViewCell
        
        //cell.cellView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        cell.categoryLabel.text = categories[indexPath.row]
        cell.categoryImage.image = UIImage(named: categoryIcon[indexPath.row])
        
        if DarkMode {
            cell.categoryLabel.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        } else {
            cell.categoryLabel.textColor = UIColor.black
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! ViewController
            let newFrontViewController = UINavigationController.init(rootViewController: newVC)
            let revealViewController:SWRevealViewController = self.revealViewController()
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        } else {
            CategoryID = indexPath.row
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newVC = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
            let newFrontViewController = UINavigationController.init(rootViewController: newVC)
            let revealViewController:SWRevealViewController = self.revealViewController()
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        homeTapped = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 290, height: 70)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
