//
//  CardHighlight.swift
//  Treviso4Tourists
//
//  Created by Administrator on 23/06/18.
//  Copyright © 2018 Edoardo Scarpel. All rights reserved.
//

import UIKit

@IBDesignable open class CardHighlight: Card {

    /**
     Text of the title label.
     */
    @IBInspectable public var title: String = "welcome \nto \ncards !" {
        didSet{
            titleLbl.text = title.uppercased()
            titleLbl.lineHeight(0.70)
        }
    }
    /**
     Max font size the title label.
     */
    @IBInspectable public var titleSize:CGFloat = 26
    /**
     Text of the title label of the item at the bottom.
     */
    @IBInspectable public var itemTitle: String = "Flappy Bird" {
        didSet{
            itemTitleLbl.text = itemTitle
        }
    }
    /**
     Max font size the subtitle label of the item at the bottom.
     */
    @IBInspectable public var itemTitleSize: CGFloat = 16
    /**
     Text of the subtitle label of the item at the bottom.
     */
    @IBInspectable public var itemSubtitle: String = "Flap that !" {
        didSet{
            itemSubtitleLbl.text = itemSubtitle
        }
    }
    /**
     Max font size the subtitle label of the item at the bottom.
     */
    @IBInspectable public var itemSubtitleSize: CGFloat = 14
    /**
     Image displayed in the icon ImageView.
     */
    @IBInspectable public var icon: UIImage? {
        didSet{
            iconIV.image = icon
            bgIconIV.image = icon
        }
    }
    @IBInspectable public var iconSize: CGSize = CGSize(width: 100, height: 100) {
        didSet{
            iconIVSize = iconSize
        }
    }
    /**
     Corner radius for the icon ImageView
     */
    @IBInspectable public var iconRadius: CGFloat = 16 {
        didSet{
            iconIV.layer.cornerRadius = iconRadius
            bgIconIV.layer.cornerRadius = iconRadius*2
        }
    }
    /**
     Text for the card's button.
     */
    @IBInspectable public var buttonText: String = "leggi" {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    //Priv Vars
    private var iconIV = UIImageView()
    public var actionBtn = UIButton()
    private var titleLbl = UILabel ()
    private var itemTitleLbl = UILabel()
    private var itemSubtitleLbl = UILabel()
    private var lightColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
    private var bgIconIV = UIImageView()
    private var iconIVSize = CGSize()
    
    fileprivate var btnWidth = CGFloat()
    
    // View Life Cycle
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override  func initialize() {
        super.initialize()
        
        actionBtn.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchUpInside)
        
        backgroundIV.addSubview(iconIV)
        backgroundIV.addSubview(titleLbl)
        backgroundIV.addSubview(itemTitleLbl)
        backgroundIV.addSubview(itemSubtitleLbl)
        backgroundIV.addSubview(actionBtn)
        
        if backgroundImage == nil {  backgroundIV.addSubview(bgIconIV); }
        else { bgIconIV.alpha = 0 }
    }
    
  
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //Draw
        bgIconIV.image = icon
        bgIconIV.alpha = backgroundImage != nil ? 0 : 0.6
        bgIconIV.clipsToBounds = true
        
        iconIV.image = icon
        iconIV.clipsToBounds = true
        
        titleLbl.text = title.uppercased()
        titleLbl.textColor = textColor
        titleLbl.font = UIFont.systemFont(ofSize: titleSize, weight: .heavy)
        titleLbl.adjustsFontSizeToFitWidth = true
        titleLbl.lineHeight(0.70)
        titleLbl.minimumScaleFactor = 0.1
        titleLbl.lineBreakMode = .byTruncatingTail
        titleLbl.numberOfLines = 3
        backgroundIV.bringSubview(toFront: titleLbl)
        
        itemTitleLbl.textColor = textColor
        itemTitleLbl.text = itemTitle
        itemTitleLbl.font = UIFont.boldSystemFont(ofSize: itemTitleSize)
        itemTitleLbl.adjustsFontSizeToFitWidth = true
        itemTitleLbl.minimumScaleFactor = 0.1
        itemTitleLbl.lineBreakMode = .byTruncatingTail
        itemTitleLbl.numberOfLines = 0

        itemSubtitleLbl.textColor = textColor
        itemSubtitleLbl.text = itemSubtitle
        itemSubtitleLbl.font = UIFont.systemFont(ofSize: itemSubtitleSize)
        itemSubtitleLbl.adjustsFontSizeToFitWidth = true
        itemSubtitleLbl.minimumScaleFactor = 0.1
        itemSubtitleLbl.lineBreakMode = .byTruncatingTail
        itemSubtitleLbl.numberOfLines = 2
        itemSubtitleLbl.sizeToFit()
        
        actionBtn.backgroundColor = UIColor.clear
        actionBtn.layer.backgroundColor = lightColor.cgColor
        actionBtn.clipsToBounds = true
        var btnTitle = NSAttributedString()
        if DarkMode {
            btnTitle = NSAttributedString(string: buttonText.uppercased(), attributes: [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16, weight: .black), NSAttributedStringKey.foregroundColor : UIColor.white])
            actionBtn.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            actionBtn.layer.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0).cgColor
        } else {
            btnTitle = NSAttributedString(string: buttonText.uppercased(), attributes: [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16, weight: .black), NSAttributedStringKey.foregroundColor : UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)])
            actionBtn.backgroundColor = UIColor.white
            actionBtn.layer.backgroundColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0, alpha: 1.0).cgColor
        }
        actionBtn.setAttributedTitle(btnTitle, for: .normal)
        
        btnWidth = CGFloat((buttonText.count + 2) * 10)
        
        layout()
        
    }
    
    override func layout(animating: Bool = true) {
        super.layout(animating: animating)
        
        let gimme = LayoutHelper(rect: backgroundIV.frame)
        
        iconIV.frame = CGRect(x: insets,
                              y: insets,
                              width: iconIVSize.width,
                              height: iconIVSize.height)
        
        titleLbl.frame.origin = CGPoint(x: insets, y: gimme.Y(5, from: iconIV))
        titleLbl.frame.size.width = (originalFrame.width * 0.65) + ((backgroundIV.bounds.width - originalFrame.width)/3)
        titleLbl.frame.size.height = gimme.Y(35)
        
        itemSubtitleLbl.sizeToFit()
        itemSubtitleLbl.frame.origin = CGPoint(x: insets, y: gimme.RevY(0, height: itemSubtitleLbl.bounds.size.height) - insets)
        
        itemTitleLbl.frame = CGRect(x: insets - 2,
                                    y: gimme.RevY(0, height: gimme.Y(7), from: itemSubtitleLbl),
                                    width: gimme.X(80) - btnWidth,
                                    height: gimme.Y(9))
        
        bgIconIV.transform = CGAffineTransform.identity
        
        
        iconIV.layer.cornerRadius = iconRadius
        
        bgIconIV.frame.size = CGSize(width: iconIV.bounds.width * 2, height: iconIV.bounds.width * 2)
        bgIconIV.frame.origin = CGPoint(x: gimme.RevX(0, width: bgIconIV.frame.width) + LayoutHelper.Width(40, of: bgIconIV) , y: 0)
        
        
        bgIconIV.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/6))
        bgIconIV.layer.cornerRadius = iconRadius * 2
        
        actionBtn.frame = CGRect(x: gimme.RevX(0, width: btnWidth) - insets,
                                 y: gimme.RevY(0, height: 32) - insets,
                                 width: btnWidth,
                                 height: 32)
        actionBtn.layer.cornerRadius = actionBtn.layer.bounds.height/2
    }
   
    //Actions
    
    @objc  func buttonTapped(){
        UIView.animate(withDuration: 0.2, animations: {
            self.actionBtn.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.actionBtn.transform = CGAffineTransform.identity
            })
        }
        delegate?.cardHighlightDidTapButton?(card: self, button: actionBtn)
    }
}



