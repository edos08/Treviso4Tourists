//
//  CategoryViewController.swift
//  Treviso4Tourists
//
//  Created by Administrator on 25/06/18.
//  Copyright © 2018 Edoardo Scarpel. All rights reserved.
//

import UIKit

var CategoryID:Int = 0
var categoryItemsTitle:[String] = ["Birreria\nProsit", "Pizzeria\nMetropolis", "Zushi"]
var categoryItemsSubTitle:[String] = ["La vera birra", "La vera", "Sushi?"]
var categoryItemsTSubTitle:[String] = ["italiana", "pizza italiana", "Sishi!"]
var categoryItemsImg:[String] = ["birra", "pizza-1", "sushi-1"]
var CCFirstLabel:[String] = ["La vera", "Una pizza", "Un vero sushi"]
var CCSecondLabel:[String] = ["birra italiana", "eccezionale", "come quello giapponese"]

var inOther: Bool = false

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var lineAfterTitle: UIView!
    @IBOutlet var catsuperview: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var modalityView: UIButton!
    @IBOutlet weak var touchCardView: UIView!
    
    var leftBarButtonItem: UIBarButtonItem = UIBarButtonItem()
    var rightBarButtonItem: UIBarButtonItem = UIBarButtonItem()
    
    var firstTimes:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inHome = false

        // Do any additional setup after loading the view.
        for _ in 0...cardTitle.count - 1 {
            firstTimes.append(0)
        }
        
        self.title = categories[CategoryID]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        self.rightBarButtonItem.image = UIImage(named: "settings-3")
        self.rightBarButtonItem.target = self
        self.rightBarButtonItem.action = #selector(pushToSettings)
        self.leftBarButtonItem.image = UIImage(named: "list-3")
        self.leftBarButtonItem.target = revealViewController()
        self.leftBarButtonItem.action = #selector(SWRevealViewController.revealToggle(_:))
        self.navigationItem.leftBarButtonItem = self.leftBarButtonItem
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem
        
        let iconImg = UIImageView()
        iconImg.frame = CGRect(x: UIScreen.main.bounds.width - 80, y: 64, width: 60, height: 60)
        iconImg.image = UIImage(named: categoryIcon[CategoryID])
        view.addSubview(iconImg)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = categories[CategoryID]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        if DarkMode {
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)]
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)]
            self.navigationController?.navigationBar.tintColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            UIApplication.shared.statusBarStyle = .lightContent
            catsuperview?.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            self.modalityView.setBackgroundImage(UIImage(named: "cellview-light"), for: .normal)
            if inOther {
                for index in 0...firstTimes.count - 1 {
                    firstTimes[index] = 0
                }
                collectionView.reloadData()
                inOther = false
            }
        } else {
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.black]
            self.navigationController?.navigationBar.tintColor = UIColor(named: "#006DF0")
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
            catsuperview?.backgroundColor = UIColor.white
            self.modalityView.setBackgroundImage(UIImage(named: "cellview"), for: .normal)
            if inOther {
                for index in 0...firstTimes.count - 1 {
                    firstTimes[index] = 0
                }
                collectionView.reloadData()
                inOther = false
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        
        if firstTimes[indexPath.row] == 0 {
            cell.CardView.subviews.forEach({ $0.removeFromSuperview() })
            print("ho tolto tutto")
            let card = CardHighlight(frame: CGRect(x: 30, y: 80, width: (UIScreen.main.bounds.width - 60) , height: (UIScreen.main.bounds.width - 60) * 1.2))
            print(Int(UIScreen.main.bounds.width - 60))
            
            card.cardID = indexPath.row
            card.backgroundImage = UIImage(named: categoryItemsImg[indexPath.row])
            card.icon = UIImage(named: categoryIcon[CategoryID])
            card.title = categoryItemsTitle[indexPath.row]
            card.itemTitle = categoryItemsSubTitle[indexPath.row]
            card.itemSubtitle = categoryItemsTSubTitle[indexPath.row]
            card.textColor = UIColor.white
            card.hasParallax = true
            card.shadowBlur = 7
            card.shadowOpacity = 0.4
            card.actionBtn.isHidden = true
            card.iconSize = CGSize(width: 50, height: 50)
            
            card.CTVController = self
            
            //let cardContentVC = storyboard!.instantiateViewController(withIdentifier: "CardContent")
            //card.shouldPresent(cardContentVC, from: self, fullscreen: false)
            //card.viewofcards = cell.CardView
            
            cell.CardView.addSubview(card)
            self.firstTimes[indexPath.row] = 1
            
        }
        if DarkMode {
            cell.firstLabel.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            cell.secondLabel.textColor = UIColor(red: 126.0/255.0, green: 136.0/255.0, blue: 137.0/255.0, alpha: 1.0)
        } else {
            cell.firstLabel.textColor = UIColor.black
            cell.secondLabel.textColor = UIColor.lightGray
        }
        cell.firstLabel.text = CCFirstLabel[indexPath.row]
        cell.secondLabel.text = CCSecondLabel[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: ((UIScreen.main.bounds.width - 60) * 1.2) + 110)
    }
    
    let modalView = UIView()
    let gridBtn = UIButton()
    let listBtn = UIButton()
    var modalViewClick: Bool = false
    
    @IBAction func modalViewClicked(_ sender: UIButton) {
        modalView.frame = CGRect(x: 6, y: UIScreen.main.bounds.height - 130, width: 45, height: 80)
        if DarkMode {
            modalView.backgroundColor = UIColor(red: 16.0/255.0, green: 30.0/255.0, blue: 41.0/255.0, alpha: 1.0)
            modalView.layer.shadowColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0).cgColor
        } else {
            modalView.backgroundColor = UIColor.white
            modalView.layer.shadowColor = UIColor.darkGray.cgColor
        }
        modalView.layer.cornerRadius = 10
        modalView.layer.shadowRadius = 10
        modalView.layer.shadowOpacity = 0.1
        modalView.alpha = 0
        
        if DarkMode {
            gridBtn.setBackgroundImage(UIImage(named: "cellview-light"), for: .normal)
            listBtn.setBackgroundImage(UIImage(named: "list-light"), for: .normal)
        } else {
            gridBtn.setBackgroundImage(UIImage(named: "cellview"), for: .normal)
            listBtn.setBackgroundImage(UIImage(named: "list-3"), for: .normal)
        }
        gridBtn.setTitleColor(UIColor.blue, for: .normal)
        listBtn.setTitleColor(UIColor.blue, for: .normal)
        gridBtn.addTarget(self, action: #selector(setCellView), for: .touchUpInside)
        listBtn.addTarget(self, action: #selector(setListView), for: .touchUpInside)
        gridBtn.frame = CGRect(x: 10, y: 10, width: 25, height: 25)
        listBtn.frame = CGRect(x: 10, y: 45, width: 25, height: 25)
        gridBtn.alpha = 0
        listBtn.alpha = 0
        
        self.modalView.addSubview(gridBtn)
        self.modalView.addSubview(listBtn)
        self.view.addSubview(modalView)
        
        if !modalViewClick {
            UIView.animate(withDuration: 0.2, animations: {
                self.gridBtn.alpha = 1
                self.listBtn.alpha = 1
                self.modalView.alpha = 1
            }) { (didComplete) in
                self.modalViewClick = true
            }
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.gridBtn.alpha = 0
                self.listBtn.alpha = 0
                self.modalView.alpha = 0
            }) { (didComplete) in
                self.modalView.removeFromSuperview()
                self.gridBtn.removeFromSuperview()
                self.listBtn.removeFromSuperview()
                self.modalViewClick = false
            }
        }
    }
    
    @objc func setListView(_ sender:UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.gridBtn.alpha = 0
            self.listBtn.alpha = 0
            self.modalView.alpha = 0
        }) { (didComplete) in
            self.modalView.removeFromSuperview()
            self.gridBtn.removeFromSuperview()
            self.listBtn.removeFromSuperview()
            self.modalViewClick = false
            if DarkMode {
                self.modalityView.setBackgroundImage(UIImage(named: "list-light"), for: .normal)
            } else {
                self.modalityView.setBackgroundImage(UIImage(named: "list-3"), for: .normal)
            }
        }
    }
    
    @objc func setCellView(_ sender:UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.gridBtn.alpha = 0
            self.listBtn.alpha = 0
            self.modalView.alpha = 0
        }) { (didComplete) in
            self.modalView.removeFromSuperview()
            self.gridBtn.removeFromSuperview()
            self.listBtn.removeFromSuperview()
            self.modalViewClick = false
            if DarkMode {
                self.modalityView.setBackgroundImage(UIImage(named: "cellview-light"), for: .normal)
            } else {
                self.modalityView.setBackgroundImage(UIImage(named: "cellview"), for: .normal)
            }
        }
    }
    
    @objc func pushToSettings() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
}

