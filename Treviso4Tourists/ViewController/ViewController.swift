//
//  ViewController.swift
//  Treviso4Tourists
//
//  Created by Administrator on 23/06/18.
//  Copyright © 2018 Edoardo Scarpel. All rights reserved.
//

import UIKit

var DarkMode:Bool = false

var cardBackground:[String] = ["castello-di-conegliano-luminoso", "alpago", "dama_castellana"]
var cardIcon:[String] = ["history", "coffee", "theater"]
var cardTitle:[String] = ["castello di\nconegliano", "Pasticceria\nAlpago", "La dama\ncastellana"]
var cardBoldSubtitle:[String] = ["Un edificio lussuoso", "Chi resiste ai dolci?", "L'evento di Conegliano"]
var cardSubtitle:[String] = ["costruito per Napoleone", "Nessuno!", "dal 10/06 al 21/06"]
var firstCL:[String] = ["Monumento", "Pasticceria", "Evento"]
var secondCL:[String] = ["della settimana", "della settimana", "della settimana"]

var fromMore:Bool = false
var inHome:Bool = true
var fromHome:Bool = false

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var BoWSuperview: UIView!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    var leftBarButtonItem: UIBarButtonItem = UIBarButtonItem()
    var rightBarButtonItem: UIBarButtonItem = UIBarButtonItem()
    let closeMenuView = UIView()
    open let iconImg = UIImageView()
    
    var firstTimes:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inHome = true
        
        if let x = UserDefaults.standard.object(forKey: "darkmode") as? Bool {
            DarkMode = x
        }
        
        for _ in 0...cardTitle.count - 1 {
            firstTimes.append(0)
        }
        
        self.title = "Best of Week"
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
        
        iconImg.frame = CGRect(x: UIScreen.main.bounds.width - 80, y: 64, width: 60, height: 60)
        iconImg.image = UIImage(named: "first")
        self.view.addSubview(iconImg)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        inHome = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Best of Week"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        if DarkMode {
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)]
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)]
            self.navigationController?.navigationBar.tintColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            UIApplication.shared.statusBarStyle = .lightContent
            BoWSuperview?.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            for index in 0...firstTimes.count - 1 {
                firstTimes[index] = 0
            }
            cardCollectionView.reloadData()
        } else {
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.black]
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.black]
            self.navigationController?.navigationBar.tintColor = UIColor(named: "#006DF0")
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
            BoWSuperview?.backgroundColor = UIColor.white
            for index in 0...firstTimes.count - 1 {
                firstTimes[index] = 0
            }
            cardCollectionView.reloadData()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y > 0 {
            UIView.animate(withDuration: 0.1) {
                self.iconImg.alpha = 0
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.y
        if scrollOffset == 0 {
            UIView.animate(withDuration: 0.1) {
                self.iconImg.alpha = 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(cardTitle.count)
        return cardTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardsCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        
        if firstTimes[indexPath.row] == 0 {
            
            let card = CardHighlight(frame: CGRect(x: 30, y: 80, width: (UIScreen.main.bounds.width - 60) , height: (UIScreen.main.bounds.width - 60) * 1.2))
            print(Int(UIScreen.main.bounds.width - 60))
            
            card.cardID = indexPath.row
            card.backgroundImage = UIImage(named: cardBackground[indexPath.row])
            card.icon = UIImage(named: cardIcon[indexPath.row])
            card.title = cardTitle[indexPath.row]
            card.itemTitle = cardBoldSubtitle[indexPath.row]
            card.itemSubtitle = cardSubtitle[indexPath.row]
            card.textColor = UIColor.white
            
            card.hasParallax = true
            
            card.shadowBlur = 7
            card.shadowOpacity = 0.4
            
            card.actionBtn.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchUpInside)
            
            card.iconSize = CGSize(width: 50, height: 50)
            
            card.IconImage = self.iconImg
            
            if DarkMode {
                card.shadowColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            } else {
                card.shadowColor = UIColor.white
            }
            
            let cardContentVC = storyboard!.instantiateViewController(withIdentifier: "CardContent")
            card.shouldPresent(cardContentVC, from: self, fullscreen: false)
            //card.viewofcards = cell.CardView
            
            cell.CardView.addSubview(card)
            
            if DarkMode {
                card.actionBtn.titleLabel?.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
                card.actionBtn.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
                card.actionBtn.layer.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0).cgColor
            } else {
                card.actionBtn.titleLabel?.textColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                card.actionBtn.backgroundColor = UIColor.white
                card.actionBtn.layer.backgroundColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0, alpha: 1.0).cgColor
            }
            
            self.firstTimes[indexPath.row] = 1
        }
        
        if DarkMode {
            cell.firstLabel.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            cell.secondLabel.textColor = UIColor(red: 126.0/255.0, green: 136.0/255.0, blue: 137.0/255.0, alpha: 1.0)
        } else {
            cell.firstLabel.textColor = UIColor.black
            cell.secondLabel.textColor = UIColor.lightGray
        }
        
        cell.firstLabel.text = firstCL[indexPath.row]
        cell.secondLabel.text = secondCL[indexPath.row]
        
        return cell
    }
    
    /*func hideIconImg() {
        self.iconImg.alpha = 0
    }*/
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: ((UIScreen.main.bounds.width - 60) * 1.2) + 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("toccato2")
    }
    
    @objc func buttonTapped(sender: UIButton){
        print("toccato")
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                sender.transform = CGAffineTransform.identity
            })
        }
        //---------------------------- DO SOME STUFF HERE ----------------------------
        let detailViewController = getDetailViewController().passDetailViewController()
        detailViewController.dismiss(animated: true) {
            print("andata alla stra grande")
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "ReadMore") as! ReadMoreViewController
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @objc func pushToSettings() {
        fromHome = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
}
