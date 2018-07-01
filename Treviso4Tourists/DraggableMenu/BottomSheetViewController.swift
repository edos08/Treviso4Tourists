//
//  BottomSheetViewController.swift
//  Treviso4Tourists
//
//  Created by Administrator on 30/06/18.
//  Copyright © 2018 Edoardo Scarpel. All rights reserved.
//

import UIKit
import MapKit

var mapViewController: MapViewController?

class BottomSheetViewController: UIViewController {
    // holdView can be UIImageView instead
    @IBOutlet weak var holdView: UIView!
    @IBOutlet weak public var left: UIButton!
    @IBOutlet weak var right: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var indicationiOSMaps: UIButton!
    
    var fullView: CGFloat {
        if homeTapped {
            return CGFloat(UIScreen.main.bounds.height - 364)
        } else {
            return CGFloat(UIScreen.main.bounds.height - 300)
        }
    }
    var partialView: CGFloat {
        if homeTapped {
            return UIScreen.main.bounds.height - 104
        } else {
            return UIScreen.main.bounds.height - 40
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.panGesture(_:)))
        view.addGestureRecognizer(gesture)
        
        titleLabel.text = "Birreria da Prosit"
        bottomLabel.text = "Via XX Settembre, 58, 31015 Conegliano TV"
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            let frame = self?.view.frame
            if homeTapped {
                self?.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 40 - 64, width: frame!.width, height: frame!.height)
            } else {
                self?.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 40, width: frame!.width, height: frame!.height)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rightButton(_ sender: AnyObject) {
        print("clicked")
    }
    
    @IBAction func close(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.3, animations: {
            let frame = self.view.frame
            self.view.frame = CGRect(x: 0, y: self.partialView, width: frame.width, height: frame.height)
        }) 
    }
    
    @objc func resetView() {
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            let frame = self?.view.frame
            if homeTapped {
                self?.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 40 - 64, width: frame!.width, height: frame!.height)
            } else {
                self?.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 40, width: frame!.width, height: frame!.height)
            }
        })
    }
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        let y = self.view.frame.minY
        if ( y + translation.y >= fullView) && (y + translation.y <= partialView ) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                }
                
                }, completion: nil)
        }
    }
    
    func setupViews() {
        view.layer.cornerRadius = 5
        holdView.layer.cornerRadius = 3
        if DarkMode {
            titleLabel.textColor = UIColor.white
            bottomLabel.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            addressLabel.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            line.backgroundColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        } else {
            titleLabel.textColor = UIColor.black
            bottomLabel.textColor = UIColor.black
            addressLabel.textColor = UIColor.black
            line.backgroundColor = UIColor.black
        }
        if DarkMode {
            holdView.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
        } else {
            holdView.backgroundColor = UIColor.white
        }
        left.layer.cornerRadius = left.frame.height / 2
        right.layer.cornerRadius = right.frame.height / 2
        indicationiOSMaps.layer.cornerRadius = indicationiOSMaps.frame.height / 2
        if DarkMode{
            left.backgroundColor = UIColor.white
            right.backgroundColor = UIColor.white
            indicationiOSMaps.backgroundColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            indicationiOSMaps.setAttributedTitle(NSAttributedString(string: ("portami al posto").uppercased(), attributes: [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16, weight: .black), NSAttributedStringKey.foregroundColor : UIColor.white]), for: .normal)
            left.setImage(UIImage(named: "walking"), for: .normal)
            right.setImage(UIImage(named: "car"), for: .normal)
        } else {
            left.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            right.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            indicationiOSMaps.backgroundColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            indicationiOSMaps.setAttributedTitle(NSAttributedString(string: ("portami al posto").uppercased(), attributes: [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16, weight: .black), NSAttributedStringKey.foregroundColor : UIColor.white]), for: .normal)
            left.setImage(UIImage(named: "walking-white"), for: .normal)
            right.setImage(UIImage(named: "car-white"), for: .normal)
        }
        left.imageView?.contentMode = .scaleAspectFit
        right.imageView?.contentMode = .scaleAspectFit
        left.addTarget(self, action: #selector(resetView), for: .touchUpInside)
        right.addTarget(self, action: #selector(resetView), for: .touchUpInside)
        indicationiOSMaps.addTarget(self, action: #selector(openMapForPlace), for: .touchUpInside)
        view.clipsToBounds = true
    }
    
    func prepareBackgroundView(){
        let bluredView = UIView()
        if DarkMode {
            bluredView.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
        } else {
            bluredView.backgroundColor = UIColor.white
        }
        bluredView.frame = UIScreen.main.bounds
        bluredView.frame.origin = CGPoint(x: 0, y: 20)
        bluredView.layer.cornerRadius = 10
        
        view.insertSubview(bluredView, at: 0)
    }
    
    @objc func openMapForPlace() {
        let latitude: CLLocationDegrees = 45.8865375
        let longitude: CLLocationDegrees = 12.296896500000003
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Birreria da Prosit"
        mapItem.openInMaps(launchOptions: options)
    }

}
