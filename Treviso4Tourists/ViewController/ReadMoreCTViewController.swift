//
//  ReadMoreCTViewController.swift
//  Treviso4Tourists
//
//  Created by Administrator on 26/06/18.
//  Copyright © 2018 Edoardo Scarpel. All rights reserved.
//

import UIKit

var imageContent:[String] = ["birracontent-1", "birracontent-2", "birracontent-3"]

class ReadMoreCTViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var principalImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var dateAuthorLabel: UILabel!
    @IBOutlet var firstParagraph: UILabel!
    @IBOutlet var secondParagraph: UILabel!
    @IBOutlet var imageDescription: UILabel!
    @IBOutlet var superView: UIView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    let blackBackgroundView = UIView()
    let zoomImageView = UIImageView()
    let coverImage = UIView()
    let doneButton = UIButton()
    let descLabel = UILabel()
    var startinImage = UIImageView()
    var fromCV:Bool = false
    var CTClicked:Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Alpago"
        
        titleLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        subTitleLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        dateAuthorLabel.text = "Dario Vazzi - 24/06/2018"
        firstParagraph.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vel mauris dictum, vulputate tellus id, lacinia leo. Quisque pharetra porta mauris in fringilla. Vivamus iaculis consectetur purus sed suscipit. Donec maximus porta enim, at dignissim mauris pellentesque sit amet. Fusce non ultrices erat. Nulla pretium et nisi vel interdum. Fusce a ornare sapien. Nunc id egestas ligula. Nunc laoreet sapien sed augue aliquet iaculis. Pellentesque nulla neque, gravida id lacus vitae, vulputate fermentum neque.\n\nMauris id nunc auctor, vestibulum erat eu, viverra ligula. Nulla facilisi. Nunc non placerat quam. Curabitur quis ligula sit amet libero tempor euismod. Vivamus eu nibh interdum, finibus diam quis, sollicitudin libero. Vestibulum et ante a neque ultrices auctor. In hac habitasse platea dictumst. Nulla sodales elit quis augue suscipit, at aliquam dui dapibus. Nam ex tortor, auctor vel odio aliquam, egestas congue justo. Morbi vitae mauris dapibus, consectetur velit sed, hendrerit elit. Sed cursus massa a mauris commodo lobortis. Donec non sodales leo. Integer sit amet nulla a dolor mollis ultrices.\n\nPhasellus vel tortor arcu. Cras et nisl id eros interdum luctus. Integer interdum leo ac rhoncus facilisis. Proin porta, urna quis facilisis suscipit, ex erat porttitor mi, vitae rutrum lacus purus quis dolor. Nullam luctus tempor libero in maximus. Morbi sit amet libero nec nisi vehicula facilisis. Nulla non mi urna."
        secondParagraph.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vel mauris dictum, vulputate tellus id, lacinia leo. Quisque pharetra porta mauris in fringilla. Vivamus iaculis consectetur purus sed suscipit. Donec maximus porta enim, at dignissim mauris pellentesque sit amet. Fusce non ultrices erat. Nulla pretium et nisi vel interdum. Fusce a ornare sapien. Nunc id egestas ligula. Nunc laoreet sapien sed augue aliquet iaculis.\n\nPellentesque nulla neque, gravida id lacus vitae, vulputate fermentum neque. Mauris id nunc auctor, vestibulum erat eu, viverra ligula. Nulla facilisi. Nunc non placerat quam. Curabitur quis ligula sit amet libero tempor euismod. Vivamus eu nibh interdum, finibus diam quis, sollicitudin libero. Vestibulum et ante a neque ultrices auctor. In hac habitasse platea dictumst. Nulla sodales elit quis augue suscipit, at aliquam dui dapibus. Nam ex tortor, auctor vel odio aliquam, egestas congue justo.\n\nMorbi vitae mauris dapibus, consectetur velit sed, hendrerit elit. Sed cursus massa a mauris commodo lobortis. Donec non sodales leo. Integer sit amet nulla a dolor mollis ultrices. Phasellus vel tortor arcu. Cras et nisl id eros interdum luctus. Integer interdum leo ac rhoncus facilisis. Proin porta, urna quis facilisis suscipit, ex erat porttitor mi, vitae rutrum lacus purus quis dolor. Nullam luctus tempor libero in maximus. Morbi sit amet libero nec nisi vehicula facilisis. Nulla non mi urna."
        imageDescription.text = "Le Barchette - Pasticceria da Alpago"
        
        principalImage.isUserInteractionEnabled = true
        principalImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.secondImage)))
        self.navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "black"), for: UIBarMetrics.default)
        
        inOther = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fromMore = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.topItem!.title = ""
        self.title = "Alpago"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "black"), for: .default)
        if DarkMode {
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)]
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)]
            self.navigationController?.navigationBar.tintColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            UIApplication.shared.statusBarStyle = .lightContent
            superView.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            titleLabel.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            subTitleLabel.textColor = UIColor(red: 151.0/255.0, green: 159.0/255.0, blue: 154.0/255.0, alpha: 1.0)
            dateAuthorLabel.textColor = UIColor(red: 126.0/255.0, green: 136.0/255.0, blue: 137.0/255.0, alpha: 1.0)
            firstParagraph.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            secondParagraph.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            imageDescription.textColor = UIColor(red: 126.0/255.0, green: 136.0/255.0, blue: 137.0/255.0, alpha: 1.0)
        } else {
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            UIApplication.shared.statusBarStyle = .lightContent
            superView.backgroundColor = UIColor.white
            titleLabel.textColor = UIColor.black
            subTitleLabel.textColor = UIColor.darkGray
            dateAuthorLabel.textColor = UIColor.lightGray
            firstParagraph.textColor = UIColor.black
            secondParagraph.textColor = UIColor.black
            imageDescription.textColor = UIColor.lightGray
        }
    }
    
    @objc func secondImage() {
        startinImage = UIImageView()
        startinImage = principalImage
        fromCV = false
        zoomInImage()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        
        //cell.imageContent.image = UIImage(named: imageContent[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let cellframe = attributes.frame
        let cellframeInSuperview = collectionView.convert(cellframe, from: collectionView.superview)
        
        let sottr:Float = Float(UIScreen.main.bounds.width) - 50.0
        let cellFr:Float =  30.0 - Float(cellframeInSuperview.origin.x)
        let result:Float = sottr * Float(indexPath.row)
        
        print("X: \(cellFr + result)")
        
        let CLVsuper = imageCollectionView.superview?.convert(imageCollectionView.frame, to: nil)
        print("Y: \(Float((CLVsuper?.origin.y)!))")
        
        startinImage = UIImageView()
        
        self.startinImage.frame = CGRect(x: CGFloat(cellFr + result), y: (CLVsuper?.origin.y)!, width: UIScreen.main.bounds.width - 60, height: 200)
        self.startinImage.image = UIImage(named: imageContent[indexPath.row])
        
        self.CTClicked = true
        self.fromCV = true
        zoomInImage()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 60, height: 200)
    }
    
    func zoomInImage() {
        
        if fromCV {
            let startingFrame = self.startinImage.frame
            
            var betterFrame = startingFrame
            betterFrame.origin.y = startingFrame.origin.y - 64
            
            self.startinImage.alpha = 0
            
            coverImage.frame = betterFrame
            if DarkMode {
                coverImage.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            } else {
                coverImage.backgroundColor = UIColor.white
            }
            coverImage.alpha = 1
            self.view.addSubview(coverImage)
            
            blackBackgroundView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            blackBackgroundView.backgroundColor = UIColor.black
            blackBackgroundView.alpha = 0
            blackBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.zoomOutImage)))
            self.view.addSubview(blackBackgroundView)
            
            doneButton.frame = CGRect(x: self.view.frame.width - 60, y: 4, width: 60, height: 30)
            doneButton.setTitle("Fine", for: .normal)
            doneButton.setTitleColor(UIColor.white, for: .normal)
            doneButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.zoomOutImage)))
            self.view.addSubview(doneButton)
            doneButton.alpha = 0
            
            let heightD = (self.view.frame.width / startingFrame.width) * startingFrame.height
            let yD  = (self.view.frame.height / 2) - (heightD / 2)
            
            descLabel.frame = CGRect(x: 0, y: heightD + yD + 10, width: UIScreen.main.bounds.width, height: 20)
            descLabel.text = imageDescription.text
            descLabel.textColor = UIColor.lightGray
            descLabel.textAlignment = .center
            descLabel.alpha = 0
            self.view.addSubview(descLabel)
            
            zoomImageView.frame = betterFrame
            zoomImageView.image = self.startinImage.image
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            self.view.addSubview(zoomImageView)
            
            UIView.animate(withDuration: 0.25) {
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                let y  = (self.view.frame.height / 2) - (height / 2)
                
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                
                self.blackBackgroundView.alpha = 1
                self.doneButton.alpha = 1
                self.descLabel.alpha = 1
            }
        } else if let startingFrame = startinImage.superview?.convert(startinImage.frame, to: nil) {
            
            var betterFrame = startingFrame
            betterFrame.origin.y = startingFrame.origin.y - 64
            
            self.startinImage.alpha = 0
            
            blackBackgroundView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            blackBackgroundView.backgroundColor = UIColor.black
            blackBackgroundView.alpha = 0
            blackBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.zoomOutImage)))
            self.view.addSubview(blackBackgroundView)
            
            doneButton.frame = CGRect(x: self.view.frame.width - 60, y: 4, width: 60, height: 30)
            doneButton.setTitle("Fine", for: .normal)
            doneButton.setTitleColor(UIColor.white, for: .normal)
            doneButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.zoomOutImage)))
            self.view.addSubview(doneButton)
            doneButton.alpha = 0
            
            let heightD = (self.view.frame.width / startingFrame.width) * startingFrame.height
            let yD  = (self.view.frame.height / 2) - (heightD / 2)
            
            descLabel.frame = CGRect(x: 0, y: heightD + yD + 10, width: UIScreen.main.bounds.width, height: 20)
            descLabel.text = imageDescription.text
            descLabel.textColor = UIColor.lightGray
            descLabel.textAlignment = .center
            descLabel.alpha = 0
            self.view.addSubview(descLabel)
            
            zoomImageView.frame = betterFrame
            zoomImageView.image = self.startinImage.image
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            self.view.addSubview(zoomImageView)
            
            UIView.animate(withDuration: 0.25) {
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                let y  = (self.view.frame.height / 2) - (height / 2)
                
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                
                self.blackBackgroundView.alpha = 1
                self.doneButton.alpha = 1
                self.descLabel.alpha = 1
            }
        }
        
    }
    
    @objc func zoomOutImage() {
        if fromCV {
            let startingFrame = self.startinImage.frame
            UIView.animate(withDuration: 0.25, animations: {
                var betterFrame = startingFrame
                betterFrame.origin.y = startingFrame.origin.y - 64
                self.zoomImageView.frame = betterFrame
                self.doneButton.alpha = 0
                self.blackBackgroundView.alpha = 0
                self.descLabel.alpha = 0
            }) { (didComplete) in
                self.zoomImageView.removeFromSuperview()
                self.doneButton.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.descLabel.removeFromSuperview()
                self.coverImage.alpha = 0
                self.coverImage.removeFromSuperview()
                self.startinImage.alpha = 1
            }
        } else if let startingFrame = startinImage.superview?.convert(startinImage.frame, to: nil) {
            UIView.animate(withDuration: 0.25, animations: {
                var betterFrame = startingFrame
                betterFrame.origin.y = startingFrame.origin.y - 64
                self.zoomImageView.frame = betterFrame
                self.doneButton.alpha = 0
                self.blackBackgroundView.alpha = 0
                self.descLabel.alpha = 0
            }) { (didComplete) in
                self.zoomImageView.removeFromSuperview()
                self.doneButton.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.descLabel.removeFromSuperview()
                self.startinImage.alpha = 1
            }
        }
        
    }
}
