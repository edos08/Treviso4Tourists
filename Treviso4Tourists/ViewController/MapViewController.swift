//
//  MapViewController.swift
//  Treviso4Tourists
//
//  Created by Administrator on 30/06/18.
//  Copyright © 2018 Edoardo Scarpel. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var placeLocation: CLLocationCoordinate2D?
    let tap = UITapGestureRecognizer(target: self, action: #selector(mapViewType1))
    
    let mapViewType = UIView()
    var startingFrame = CGRect()
    let mapViewTypeButton1 = UIButton()
    let mapViewTypeButton2 = UIButton()
    let mapViewTypeButton3 = UIButton()
    let mapViewTypeImage1 = UIImageView()
    let mapViewTypeImage2 = UIImageView()
    let mapViewTypeImage3 = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Birreria da Prosit"
        mapViewController = self
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        setupPlaceLocation()
        setupViews()
        addBottomSheetView()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swiped(gesture:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determinMyCurrentLocation()
    }
    
    func addBottomSheetView(scrollable: Bool? = true) {
        let bottomSheetVC = scrollable! ? BottomSheetViewController() : BottomSheetViewController()
        
        self.addChildViewController(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParentViewController: self)
        
        bottomSheetVC.left.addTarget(self, action: #selector(routeWalk), for: .touchUpInside)
        bottomSheetVC.right.addTarget(self, action: #selector(routeCar), for: .touchUpInside)
        
        let height = view.frame.height
        let width  = view.frame.width
        if homeTapped {
            bottomSheetVC.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 40 - 64, width: width, height: height)
        } else {
            bottomSheetVC.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 40, width: width, height: height)
        }
    }
    
    func setupViews() {
        view.addSubview(userLocationButton)
        view.addSubview(placeLocationButton)
        view.addSubview(mapViewTypeButton)
        view.addSubview(timeView)
        timeView.addSubview(timeLabel)
        timeView.addSubview(timeImage)
        view.addSubview(distanceView)
        distanceView.addSubview(distanceLabel)
        distanceView.addSubview(distanceImage)
    }
    
    @objc func routeWalk() {
        self.setupRout(transportType: 2)
    }
    
    @objc func routeCar() {
        self.setupRout(transportType: 1)
    }
    
    func setupPlaceLocation() {
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.005, 0.005)
        placeLocation = CLLocationCoordinate2DMake(45.8865375, 12.296896500000003)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(self.placeLocation!, span)
        mapView.setRegion(region, animated: false)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placeLocation!
        annotation.title = "Birreria da Prosit"
        annotation.subtitle = "Birreria da Prosit"
        mapView.addAnnotation(annotation)
    }
    
    func setupRout(transportType: Int) {
        self.mapView.removeOverlays(self.mapView.overlays)
        let sourcePlacemark = MKPlacemark(coordinate: self.userLocation)
        let destinationPlacemark = MKPlacemark(coordinate: placeLocation!)
        let directionrequest = MKDirectionsRequest()
        directionrequest.source = MKMapItem(placemark: sourcePlacemark)
        directionrequest.destination = MKMapItem(placemark: destinationPlacemark)
        if transportType == 1 {
            directionrequest.transportType = .automobile
        } else if transportType == 2 {
            directionrequest.transportType = .walking
        }
        
        let directions = MKDirections(request: directionrequest)
        directions.calculate(completionHandler: { (response, error) in
            guard let directionResponse = response else {
                if let error = error {
                    print("Error getting directions: \(error)")
                }
                return
            }
            
            let route = directionResponse.routes[0]
            self.mapView.add(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            self.setTime(time: route.expectedTravelTime)
            self.setDistance(distance: route.distance)
        })
    }
    
    func setTime(time: Double) {
        if time > 60 {
            self.timeLabel.text = "Tempo: \(Int(round(time/60))) min"
            UIView.animate(withDuration: 0.3) {
                self.timeView.frame.size = CGSize(width: 160, height: 40)
                self.timeImage.alpha = 0
                self.timeLabel.alpha = 1
            }
        } else {
            self.timeLabel.text = "Tempo: \(round(time)) sec"
            UIView.animate(withDuration: 0.3) {
                self.timeView.frame.size = CGSize(width: 160, height: 40)
                self.timeImage.alpha = 0
                self.timeLabel.alpha = 1
            }
        }
    }
    
    func setDistance(distance: Double) {
        if distance >= 1000 {
            self.distanceLabel.text = "Distanza: \(round(distance/100)/10) Km"
            UIView.animate(withDuration: 0.3) {
                self.distanceView.frame.size = CGSize(width: 160, height: 40)
                self.distanceImage.alpha = 0
                self.distanceLabel.alpha = 1
            }
        } else {
            self.distanceLabel.text = "Distanza: \(distance) m"
            UIView.animate(withDuration: 0.3) {
                self.distanceView.frame.size = CGSize(width: 160, height: 40)
                self.distanceImage.alpha = 0
                self.distanceLabel.alpha = 1
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        renderer.lineWidth = 7.0
        return renderer
    }
    
    func determinMyCurrentLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = manager.location!.coordinate
    }
    
    let userLocationButton: UIButton = {
        let button = UIButton()
        if homeTapped {
            button.frame = CGRect(x: 20, y: UIScreen.main.bounds.maxY - 70 - 64, width: 40, height: 40)
        } else {
            button.frame = CGRect(x: 20, y: UIScreen.main.bounds.maxY - 70, width: 40, height: 40)
        }
        if DarkMode {
            button.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            button.setBackgroundImage(UIImage(named: "location-white"), for: .normal)
        } else {
            button.backgroundColor = UIColor.white
            button.setBackgroundImage(UIImage(named: "location-2"), for: .normal)
        }
        button.layer.cornerRadius = 20
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 20
        button.layer.shadowColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0).cgColor
        button.addTarget(self, action: #selector(zoomInUserLocation), for: .touchUpInside)
        return button
    }()
    
    let placeLocationButton: UIButton = {
        let button = UIButton()
        if homeTapped {
            button.frame = CGRect(x: UIScreen.main.bounds.maxX - 60, y: UIScreen.main.bounds.maxY - 70 - 64, width: 40, height: 40)
        } else {
            button.frame = CGRect(x: UIScreen.main.bounds.maxX - 60, y: UIScreen.main.bounds.maxY - 70, width: 40, height: 40)
        }
        if DarkMode {
            button.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            button.setBackgroundImage(UIImage(named: "placelocation-white"), for: .normal)
        } else {
            button.backgroundColor = UIColor.white
            button.setBackgroundImage(UIImage(named: "placelocation"), for: .normal)
        }
        button.layer.cornerRadius = 20
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 20
        button.layer.shadowColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0).cgColor
        button.addTarget(self, action: #selector(zoomInPlaceLocation), for: .touchUpInside)
        return button
    }()
    
    let mapViewTypeButton: UIButton = {
        let button = UIButton()
        if homeTapped {
            button.frame = CGRect(x: UIScreen.main.bounds.maxX - 60, y: 20, width: 40, height: 40)
        } else {
            button.frame = CGRect(x: UIScreen.main.bounds.maxX - 60, y: 84, width: 40, height: 40)
        }
        if DarkMode {
            button.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            button.setBackgroundImage(UIImage(named: "map-little-white"), for: .normal)
        } else {
            button.backgroundColor = UIColor.white
            button.setBackgroundImage(UIImage(named: "map-little"), for: .normal)
        }
        button.layer.cornerRadius = 20
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 20
        button.layer.shadowColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0).cgColor
        button.addTarget(self, action: #selector(changeMapView), for: .touchUpInside)
        return button
    }()
    
    let timeView: UIView = {
        let timeview = UIView()
        if homeTapped {
            timeview.frame = CGRect(x: 20, y: 20, width: 40, height: 40)
        } else {
            timeview.frame = CGRect(x: 20, y: 84, width: 40, height: 40)
        }
        if DarkMode {
            timeview.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
        } else {
            timeview.backgroundColor = UIColor.white
        }
        timeview.layer.cornerRadius = 20
        timeview.layer.shadowOpacity = 0.2
        timeview.layer.shadowRadius = 20
        timeview.layer.shadowColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0).cgColor
        return timeview
    }()
    
    let timeImage: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 5, y: 5, width: 30, height: 30)
        if DarkMode {
            image.image = UIImage(named: "time-white")
        } else {
            image.image = UIImage(named: "time")
        }
        return image
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 15, y: 10, width: 140, height: 20)
        label.text = "Tempo: -- min"
        if DarkMode {
            label.textColor = UIColor.white
        } else {
            label.textColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
        label.alpha = 0
        return label
    }()
    
    let distanceView: UIView = {
        let distanceview = UIView()
        if homeTapped {
            distanceview.frame = CGRect(x: 20, y: 80, width: 40, height: 40)
        } else {
            distanceview.frame = CGRect(x: 20, y: 134, width: 40, height: 40)
        }
        if DarkMode {
            distanceview.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
        } else {
            distanceview.backgroundColor = UIColor.white
        }
        distanceview.layer.cornerRadius = 20
        distanceview.layer.shadowOpacity = 0.2
        distanceview.layer.shadowRadius = 20
        distanceview.layer.shadowColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0).cgColor
        return distanceview
    }()
    
    let distanceImage: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 5, y: 5, width: 30, height: 30)
        if DarkMode {
            image.image = UIImage(named: "distance-white")
        } else {
            image.image = UIImage(named: "distance")
        }
        return image
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 15, y: 10, width: 140, height: 20)
        label.text = "Tempo: -- min"
        if DarkMode {
            label.textColor = UIColor.white
        } else {
            label.textColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
        label.alpha = 0
        return label
    }()
    
    @objc func swiped(gesture: UIGestureRecognizer)
    {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer
        {
            switch swipeGesture.direction
            {
                
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped Right")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped Left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped Up")
                
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped Down")
                
            default:
                break
            }
        }
    }
    
    @objc func zoomInPlaceLocation() {
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.005, 0.005)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(45.8865375, 12.296896500000003)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func zoomInUserLocation() {
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.005, 0.005)
        let region: MKCoordinateRegion = MKCoordinateRegionMake((self.userLocation), span)
        mapView.setRegion(region, animated: true)
        
        self.mapView.showsUserLocation = true
    }

    @objc func changeMapView() {
        startingFrame = mapViewTypeButton.frame
        mapViewType.frame = startingFrame
        if DarkMode {
            mapViewType.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
        } else {
            mapViewType.backgroundColor = UIColor.white
        }
        mapViewType.layer.cornerRadius = 20
        mapViewType.layer.shadowOpacity = 0.2
        mapViewType.layer.shadowRadius = 20
        mapViewType.layer.shadowColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0).cgColor
        
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        
        mapViewTypeButton1.setTitle("Standard", for: .normal)
        mapViewTypeButton2.setTitle("Satellite", for: .normal)
        mapViewTypeButton3.setTitle("Ibrida", for: .normal)
        if DarkMode {
            mapViewTypeButton1.setTitleColor(UIColor.white, for: .normal)
            mapViewTypeButton2.setTitleColor(UIColor.white, for: .normal)
            mapViewTypeButton3.setTitleColor(UIColor.white, for: .normal)
        } else {
            mapViewTypeButton1.setTitleColor(UIColor.black, for: .normal)
            mapViewTypeButton2.setTitleColor(UIColor.black, for: .normal)
            mapViewTypeButton3.setTitleColor(UIColor.black, for: .normal)
        }
        mapViewTypeButton1.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        mapViewTypeButton2.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        mapViewTypeButton3.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        mapViewTypeButton1.addTarget(self, action: #selector(mapViewType1), for: .touchUpInside)
        mapViewTypeButton2.addTarget(self, action: #selector(mapViewType2), for: .touchUpInside)
        mapViewTypeButton3.addTarget(self, action: #selector(mapViewType3), for: .touchUpInside)
        mapViewTypeButton1.alpha = 0
        mapViewTypeButton2.alpha = 0
        mapViewTypeButton3.alpha = 0
    
        if DarkMode {
            mapViewTypeImage1.image = UIImage(named: "map-view-white")
            mapViewTypeImage2.image = UIImage(named: "map-satellite-white")
            mapViewTypeImage3.image = UIImage(named: "map-hybrid-white")
        } else {
            mapViewTypeImage1.image = UIImage(named: "map-view")
            mapViewTypeImage2.image = UIImage(named: "map-satellite")
            mapViewTypeImage3.image = UIImage(named: "map-hybrid")
        }
        mapViewTypeImage1.contentMode = .scaleAspectFill
        mapViewTypeImage1.clipsToBounds = true
        mapViewTypeImage2.contentMode = .scaleAspectFill
        mapViewTypeImage2.clipsToBounds = true
        mapViewTypeImage3.contentMode = .scaleAspectFill
        mapViewTypeImage3.clipsToBounds = true
        mapViewTypeImage1.addGestureRecognizer(tap)
        mapViewTypeImage2.addGestureRecognizer(tap)
        mapViewTypeImage3.addGestureRecognizer(tap)
        mapViewTypeImage1.alpha = 0
        mapViewTypeImage2.alpha = 0
        mapViewTypeImage3.alpha = 0
        
        self.mapViewTypeButton1.frame.origin = CGPoint(x: 20, y: 20)
        self.mapViewTypeButton2.frame.origin = CGPoint(x: 20, y: 20)
        self.mapViewTypeButton3.frame.origin = CGPoint(x: 20, y: 20)
        self.mapViewTypeImage1.frame.origin = CGPoint(x: 20, y: 20)
        self.mapViewTypeImage2.frame.origin = CGPoint(x: 20, y: 20)
        self.mapViewTypeImage3.frame.origin = CGPoint(x: 20, y: 20)
        
        self.view.addSubview(mapViewType)
        self.mapViewType.addSubview(self.mapViewTypeButton1)
        self.mapViewType.addSubview(self.mapViewTypeButton2)
        self.mapViewType.addSubview(self.mapViewTypeButton3)
        self.mapViewType.addSubview(self.mapViewTypeImage1)
        self.mapViewType.addSubview(self.mapViewTypeImage2)
        self.mapViewType.addSubview(self.mapViewTypeImage3)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeMapViewType)))
        
        UIView.animate(withDuration: 0.2, animations: {
            self.mapViewType.frame = CGRect(x: UIScreen.main.bounds.width - 190, y: self.startingFrame.origin.y, width: 170, height: 130)
            self.mapViewTypeButton1.frame = CGRect(x: 60, y: 10, width: self.mapViewType.frame.width - 50, height: 30)
            self.mapViewTypeButton2.frame = CGRect(x: 60, y: 50, width: self.mapViewType.frame.width - 50, height: 30)
            self.mapViewTypeButton3.frame = CGRect(x: 60, y: 90, width: self.mapViewType.frame.width - 50, height: 30)
            self.mapViewTypeImage1.frame = CGRect(x: 20, y: 10, width: 30, height: 30)
            self.mapViewTypeImage2.frame = CGRect(x: 20, y: 50, width: 30, height: 30)
            self.mapViewTypeImage3.frame = CGRect(x: 20, y: 90, width: 30, height: 30)
            self.mapViewType.alpha = 1
            self.mapViewTypeButton1.alpha = 1
            self.mapViewTypeButton2.alpha = 1
            self.mapViewTypeButton3.alpha = 1
            self.mapViewTypeImage1.alpha = 1
            self.mapViewTypeImage2.alpha = 1
            self.mapViewTypeImage3.alpha = 1
        }) { (didAnimate) in
        }
    }
    
    @objc func closeMapViewType() {
        self.mapViewTypeButton1.removeFromSuperview()
        self.mapViewTypeButton2.removeFromSuperview()
        self.mapViewTypeButton3.removeFromSuperview()
        self.mapViewTypeImage1.removeFromSuperview()
        self.mapViewTypeImage2.removeFromSuperview()
        self.mapViewTypeImage3.removeFromSuperview()
        UIView.animate(withDuration: 0.2, animations: {
            self.mapViewType.frame = self.startingFrame
        }) { (didAnimate) in
            UIView.animate(withDuration: 0.2, animations: {
                self.mapViewType.alpha = 0
            }, completion: { (animated) in
                self.mapViewType.removeFromSuperview()
            })
            self.view.removeGestureRecognizer(self.tap)
        }
    }
    
    @objc func mapViewType1() {
        self.mapView.mapType = .standard
        self.mapViewTypeButton1.removeFromSuperview()
        self.mapViewTypeButton2.removeFromSuperview()
        self.mapViewTypeButton3.removeFromSuperview()
        self.mapViewTypeImage1.removeFromSuperview()
        self.mapViewTypeImage2.removeFromSuperview()
        self.mapViewTypeImage3.removeFromSuperview()
        UIView.animate(withDuration: 0.2, animations: {
            self.mapViewType.frame = self.startingFrame
        }) { (didAnimate) in
            if DarkMode {
                self.mapViewTypeButton.setBackgroundImage(UIImage(named: "map-little-white"), for: .normal)
            } else {
                self.mapViewTypeButton.setBackgroundImage(UIImage(named: "map-little"), for: .normal)
            }
            UIView.animate(withDuration: 0.2, animations: {
                self.mapViewType.alpha = 0
            }, completion: { (animated) in
                self.mapViewType.removeFromSuperview()
            })
            self.view.removeGestureRecognizer(self.tap)
        }
    }
    
    @objc func mapViewType2() {
        self.mapView.mapType = .satellite
        self.mapViewTypeButton1.removeFromSuperview()
        self.mapViewTypeButton2.removeFromSuperview()
        self.mapViewTypeButton3.removeFromSuperview()
        self.mapViewTypeImage1.removeFromSuperview()
        self.mapViewTypeImage2.removeFromSuperview()
        self.mapViewTypeImage3.removeFromSuperview()
        UIView.animate(withDuration: 0.2, animations: {
            self.mapViewType.frame = self.startingFrame
        }) { (didAnimate) in
            if DarkMode {
                self.mapViewTypeButton.setBackgroundImage(UIImage(named: "map-little-satellite-white"), for: .normal)
            } else {
                self.mapViewTypeButton.setBackgroundImage(UIImage(named: "map-little-satellite"), for: .normal)
            }
            UIView.animate(withDuration: 0.2, animations: {
                self.mapViewType.alpha = 0
            }, completion: { (animated) in
                self.mapViewType.removeFromSuperview()
            })
            self.view.removeGestureRecognizer(self.tap)
        }
        
    }
    
    @objc func mapViewType3() {
        self.mapView.mapType = .hybrid
        self.mapViewTypeButton1.removeFromSuperview()
        self.mapViewTypeButton2.removeFromSuperview()
        self.mapViewTypeButton3.removeFromSuperview()
        self.mapViewTypeImage1.removeFromSuperview()
        self.mapViewTypeImage2.removeFromSuperview()
        self.mapViewTypeImage3.removeFromSuperview()
        UIView.animate(withDuration: 0.2, animations: {
            self.mapViewType.frame = self.startingFrame
        }) { (didAnimate) in
            if DarkMode {
                self.mapViewTypeButton.setBackgroundImage(UIImage(named: "map-little-hybrid-white"), for: .normal)
            } else {
                self.mapViewTypeButton.setBackgroundImage(UIImage(named: "map-hybrid-little"), for: .normal)
            }
            UIView.animate(withDuration: 0.2, animations: {
                self.mapViewType.alpha = 0
            }, completion: { (animated) in
                self.mapViewType.removeFromSuperview()
            })
            self.view.removeGestureRecognizer(self.tap)
        }
        
    }
    
}
