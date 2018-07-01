//
//  CardContentViewController.swift
//  Treviso4Tourists
//
//  Created by Administrator on 24/06/18.
//  Copyright © 2018 Edoardo Scarpel. All rights reserved.
//

import UIKit

var titleCC:[String] = ["Lorem Ipsum", "Lorem Ipsum", "Lorem Ipsum"]
var firstParagraphCC:[String] = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ultrices aliquam purus, eu euismod elit tempus condimentum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ultrices aliquam purus, eu euismod elit tempus condimentum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ultrices aliquam purus, eu euismod elit tempus condimentum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ultrices aliquam purus, eu euismod elit tempus condimentum. ", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ultrices aliquam purus, eu euismod elit tempus condimentum.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ultrices aliquam purus, eu euismod elit tempus condimentum."]
var secondParagraphCC:[String] = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ultrices aliquam purus, eu euismod elit tempus condimentum. In sollicitudin, odio convallis cursus finibus, tortor risus fermentum arcu, at accumsan orci nibh at mi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ultrices aliquam purus, eu euismod elit tempus condimentum. In sollicitudin, odio convallis cursus finibus, tortor risus fermentum arcu, at accumsan orci nibh at mi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ultrices aliquam purus, eu euismod elit tempus condimentum. In sollicitudin, odio convallis cursus finibus, tortor risus fermentum arcu, at accumsan orci nibh at mi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ultrices aliquam purus, eu euismod elit tempus condimentum. In sollicitudin, odio convallis cursus finibus, tortor risus fermentum arcu, at accumsan orci nibh at mi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ultrices aliquam purus, eu euismod elit tempus condimentum. In sollicitudin, odio convallis cursus finibus, tortor risus fermentum arcu, at accumsan orci nibh at mi. ", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ultrices aliquam purus, eu euismod elit tempus condimentum. In sollicitudin, odio convallis cursus finibus, tortor risus fermentum arcu, at accumsan orci nibh at mi.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ultrices aliquam purus, eu euismod elit tempus condimentum. In sollicitudin, odio convallis cursus finibus, tortor risus fermentum arcu, at accumsan orci nibh at mi."]
var imageCC:[String] = ["castello_conegliano_notte", "alpago_content", "dama_castellana_content"]

class CardContentViewController: UIViewController {
    
    @IBOutlet public var CardContentView: UIView!
    @IBOutlet weak var titleCL: UILabel!
    @IBOutlet weak var firstParagraphCL: UILabel!
    @IBOutlet weak var imageContent: UIImageView!
    @IBOutlet weak var secondParagraphCL: UILabel!
    @IBOutlet weak var favoritesView: UIView!
    @IBOutlet weak var favoritesImage: UIImageView!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var shareImage: UIImageView!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var viewUnderScroll: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
        
        //globalDetailViewController.changeScrollViewHeight(self.viewUnderScroll.frame.he)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let getid = getID().passID()
        setCardContent(cardID: getid)
        
        setupViews()
    }
    
    func setupViews() {
        favoritesView.layer.cornerRadius = 6
        shareView.layer.cornerRadius = 6
        if DarkMode {
            CardContentView.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            titleCL.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            firstParagraphCL.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            secondParagraphCL.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            favoritesLabel.textColor = UIColor.white
            shareLabel.textColor = UIColor.white
            favoritesImage.image = UIImage(named: "favorite-empty-white")
            shareImage.image = UIImage(named: "share-white")
        } else {
            CardContentView.backgroundColor = UIColor.white
            titleCL.textColor = UIColor.black
            firstParagraphCL.textColor = UIColor.black
            secondParagraphCL.textColor = UIColor.black
            favoritesLabel.textColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            shareLabel.textColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            favoritesImage.image = UIImage(named: "favorite-empty")
            shareImage.image = UIImage(named: "share")
        }
    }
    
    func setCardContent(cardID: Int) {
        self.titleCL.text = titleCC[cardID]
        self.firstParagraphCL.text = firstParagraphCC[cardID]
        self.secondParagraphCL.text = secondParagraphCC[cardID]
        self.imageContent.image = UIImage(named: imageCC[cardID])
    }
    
}

