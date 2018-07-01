//
//  ReadMoreViewController.swift
//  Treviso4Tourists
//
//  Created by Administrator on 24/06/18.
//  Copyright © 2018 Edoardo Scarpel. All rights reserved.
//

import UIKit
import MapKit

var imageContent:[String] = ["birracontent-1", "birracontent-2", "birracontent-3"]
struct coordinates: Decodable {
    public let lat: Double = 45.8865375
    public let lon: Double = 12.296896500000003
}

class ReadMoreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var superView: UIView!
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var locationManager: CLLocationManager!
    
    let blackBackgroundView = UIView()
    let zoomImageView = UIImageView()
    let coverImage = UIView()
    let doneButton = UIButton()
    let descLabel = UILabel()
    var startinImage = UIImageView()
    var fromCV:Bool = false
    var CTClicked:Bool = false
    
    var alreadyOnePressed: Bool = false
    var alreadyTwoPressed: Bool = false
    let cellIndentifier = "ImgCollectionViewCell"
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Alpago"
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "black"), for: UIBarMetrics.default)
        self.navigationController!.navigationBar.topItem!.title = ""
        
        principalImage.isUserInteractionEnabled = true
        principalImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.secondImage)))
        /*midImage.isUserInteractionEnabled = true
        midImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.firstImage)))*/
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ImgCollectionViewCell.self, forCellWithReuseIdentifier: cellIndentifier)
        
        mapButton.addTarget(self, action: #selector(goToMapFS), for: .touchUpInside)
        
        //----------------------- BEFORE THIS -----------------------
        setupScrollView()
        setupFirstViews()
        
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
            scheduleTitleLabel.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            scheduleLabel.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            addressTitleLabel.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            addressLabel.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            segmentedControl.tintColor = UIColor.white
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
            scheduleTitleLabel.textColor = UIColor.black
            scheduleLabel.textColor = UIColor.black
            addressTitleLabel.textColor = UIColor.black
            addressLabel.textColor = UIColor.black
            segmentedControl.tintColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
        }
        inOther = true
    }
    
    @objc func secondImage() {
        startinImage = UIImageView()
        startinImage = principalImage
        fromCV = false
        zoomInImage()
    }
    
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        //x,w,t,b
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //x,w,t,b
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func setupFirstViews(){
        scheduleTitleLabel.removeFromSuperview()
        scheduleLabel.removeFromSuperview()
        addressTitleLabel.removeFromSuperview()
        addressLabel.removeFromSuperview()
        mapView.removeFromSuperview()
        mapButton.removeFromSuperview()
        
        contentView.addSubview(principalImage)
        contentView.addSubview(segmentedControl)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(dateAuthorLabel)
        contentView.addSubview(firstParagraph)
        contentView.addSubview(imageCollectionView)
        contentView.addSubview(imageDescription)
        contentView.addSubview(secondParagraph)
        contentView.addSubview(favoritesView)
        contentView.addSubview(shareView)
        favoritesView.addSubview(favoritesImage)
        favoritesView.addSubview(favoritesLabel)
        shareView.addSubview(shareImage)
        shareView.addSubview(shareLabel)
        
        
        principalImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        principalImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        principalImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        principalImage.heightAnchor.constraint(equalToConstant: 250.0).isActive = true
        
        segmentedControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: principalImage.bottomAnchor, constant: 20.0).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: (UIScreen.main.bounds.width - 60)/(UIScreen.main.bounds.width)).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20.0).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: (UIScreen.main.bounds.width - 60)/(UIScreen.main.bounds.width)).isActive = true
        
        subTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        subTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: (UIScreen.main.bounds.width - 60)/(UIScreen.main.bounds.width)).isActive = true
        
        dateAuthorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dateAuthorLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 8.0).isActive = true
        dateAuthorLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: (UIScreen.main.bounds.width - 60)/(UIScreen.main.bounds.width)).isActive = true
        
        firstParagraph.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        firstParagraph.topAnchor.constraint(equalTo: dateAuthorLabel.bottomAnchor, constant: 20.0).isActive = true
        firstParagraph.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: (UIScreen.main.bounds.width - 60)/(UIScreen.main.bounds.width)).isActive = true
        
        imageCollectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageCollectionView.topAnchor.constraint(equalTo: firstParagraph.bottomAnchor, constant: 20.0).isActive = true
        imageCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageCollectionView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        /*midImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        midImage.topAnchor.constraint(equalTo: firstParagraph.bottomAnchor, constant: 20.0).isActive = true
        midImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: (UIScreen.main.bounds.width - 60)/(UIScreen.main.bounds.width)).isActive = true
        midImage.heightAnchor.constraint(equalToConstant: 200.0).isActive = true*/
        
        imageDescription.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageDescription.topAnchor.constraint(equalTo: imageCollectionView.bottomAnchor, constant: 7.5).isActive = true
        imageDescription.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: (UIScreen.main.bounds.width - 60)/(UIScreen.main.bounds.width)).isActive = true
        
        secondParagraph.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        secondParagraph.topAnchor.constraint(equalTo: imageDescription.bottomAnchor, constant: 20.0).isActive = true
        secondParagraph.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: (UIScreen.main.bounds.width - 60)/(UIScreen.main.bounds.width)).isActive = true
        
        favoritesView.topAnchor.constraint(equalTo: secondParagraph.bottomAnchor, constant: 20.0).isActive = true
        favoritesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30.0).isActive = true
        favoritesView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        favoritesView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 70)/2).isActive = true
        favoritesView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30.0).isActive = true
        
        shareView.topAnchor.constraint(equalTo: secondParagraph.bottomAnchor, constant: 20.0).isActive = true
        shareView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30.0).isActive = true
        shareView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        shareView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 70)/2).isActive = true
        shareView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30.0).isActive = true
        
        favoritesImage.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        favoritesImage.topAnchor.constraint(equalTo: favoritesView.topAnchor, constant: 9.0).isActive = true
        favoritesImage.leadingAnchor.constraint(equalTo: favoritesView.leadingAnchor).isActive = true
        favoritesImage.trailingAnchor.constraint(equalTo: favoritesView.trailingAnchor).isActive = true
        
        favoritesLabel.topAnchor.constraint(equalTo: favoritesImage.bottomAnchor, constant: 3.0).isActive = true
        favoritesLabel.leadingAnchor.constraint(equalTo: favoritesView.leadingAnchor).isActive = true
        favoritesLabel.trailingAnchor.constraint(equalTo: favoritesView.trailingAnchor).isActive = true
        
        shareImage.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        shareImage.topAnchor.constraint(equalTo: shareView.topAnchor, constant: 9.0).isActive = true
        shareImage.leadingAnchor.constraint(equalTo: shareView.leadingAnchor).isActive = true
        shareImage.trailingAnchor.constraint(equalTo: shareView.trailingAnchor).isActive = true
        
        shareLabel.topAnchor.constraint(equalTo: shareImage.bottomAnchor, constant: 3.0).isActive = true
        shareLabel.leadingAnchor.constraint(equalTo: shareView.leadingAnchor).isActive = true
        shareLabel.trailingAnchor.constraint(equalTo: shareView.trailingAnchor).isActive = true
    }
    
    func setupSecondViews() {
        titleLabel.removeFromSuperview()
        subTitleLabel.removeFromSuperview()
        dateAuthorLabel.removeFromSuperview()
        firstParagraph.removeFromSuperview()
        imageCollectionView.removeFromSuperview()
        imageDescription.removeFromSuperview()
        secondParagraph.removeFromSuperview()
        favoritesView.removeFromSuperview()
        favoritesImage.removeFromSuperview()
        favoritesLabel.removeFromSuperview()
        shareView.removeFromSuperview()
        shareImage.removeFromSuperview()
        shareLabel.removeFromSuperview()
        
        contentView.addSubview(scheduleTitleLabel)
        contentView.addSubview(scheduleLabel)
        contentView.addSubview(addressTitleLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(mapView)
        contentView.addSubview(mapButton)
        
        scheduleTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        scheduleTitleLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20.0).isActive = true
        scheduleTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: (UIScreen.main.bounds.width - 60)/(UIScreen.main.bounds.width)).isActive = true
        
        scheduleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        scheduleLabel.topAnchor.constraint(equalTo: scheduleTitleLabel.bottomAnchor, constant: 8.0).isActive = true
        scheduleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: (UIScreen.main.bounds.width - 90)/(UIScreen.main.bounds.width)).isActive = true
        
        addressTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        addressTitleLabel.topAnchor.constraint(equalTo: scheduleLabel.bottomAnchor, constant: 20.0).isActive = true
        addressTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: (UIScreen.main.bounds.width - 60)/(UIScreen.main.bounds.width)).isActive = true
        
        addressLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        addressLabel.topAnchor.constraint(equalTo: addressTitleLabel.bottomAnchor, constant: 8.0).isActive = true
        addressLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: (UIScreen.main.bounds.width - 60)/(UIScreen.main.bounds.width)).isActive = true
        
        mapView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8.0).isActive = true
        mapView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 250.0).isActive = true
        
        mapButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        mapButton.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20.0).isActive = true
        mapButton.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        mapButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        mapButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30.0).isActive = true
    }
    
    let principalImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "birracontent-1")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let segmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.insertSegment(withTitle: "Descrizione", at: 0, animated: false)
        segment.insertSegment(withTitle: "Info e Orari", at: 1, animated: false)
        segment.selectedSegmentIndex = 0
        segment.backgroundColor = UIColor.clear
        segment.tintColor = UIColor.white
        segment.addTarget(self, action: #selector(changeView(sender:)), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        label.font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        label.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateAuthorLabel: UILabel = {
        let label = UILabel()
        label.text = "Dario Vazzi - 24/06/2018"
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let firstParagraph: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vel mauris dictum, vulputate tellus id, lacinia leo. Quisque pharetra porta mauris in fringilla. Vivamus iaculis consectetur purus sed suscipit. Donec maximus porta enim, at dignissim mauris pellentesque sit amet. Fusce non ultrices erat. Nulla pretium et nisi vel interdum. Fusce a ornare sapien. Nunc id egestas ligula. Nunc laoreet sapien sed augue aliquet iaculis. Pellentesque nulla neque, gravida id lacus vitae, vulputate fermentum neque.\n\nMauris id nunc auctor, vestibulum erat eu, viverra ligula. Nulla facilisi. Nunc non placerat quam. Curabitur quis ligula sit amet libero tempor euismod. Vivamus eu nibh interdum, finibus diam quis, sollicitudin libero. Vestibulum et ante a neque ultrices auctor. In hac habitasse platea dictumst. Nulla sodales elit quis augue suscipit, at aliquam dui dapibus. Nam ex tortor, auctor vel odio aliquam, egestas congue justo. Morbi vitae mauris dapibus, consectetur velit sed, hendrerit elit. Sed cursus massa a mauris commodo lobortis. Donec non sodales leo. Integer sit amet nulla a dolor mollis ultrices.\n\nPhasellus vel tortor arcu. Cras et nisl id eros interdum luctus. Integer interdum leo ac rhoncus facilisis. Proin porta, urna quis facilisis suscipit, ex erat porttitor mi, vitae rutrum lacus purus quis dolor. Nullam luctus tempor libero in maximus. Morbi sit amet libero nec nisi vehicula facilisis. Nulla non mi urna."
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let midImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "birracontent-1")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let imageCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()
    
    let imageDescription: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet"
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondParagraph: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vel mauris dictum, vulputate tellus id, lacinia leo. Quisque pharetra porta mauris in fringilla. Vivamus iaculis consectetur purus sed suscipit. Donec maximus porta enim, at dignissim mauris pellentesque sit amet. Fusce non ultrices erat. Nulla pretium et nisi vel interdum. Fusce a ornare sapien. Nunc id egestas ligula. Nunc laoreet sapien sed augue aliquet iaculis.\n\nPellentesque nulla neque, gravida id lacus vitae, vulputate fermentum neque. Mauris id nunc auctor, vestibulum erat eu, viverra ligula. Nulla facilisi. Nunc non placerat quam. Curabitur quis ligula sit amet libero tempor euismod. Vivamus eu nibh interdum, finibus diam quis, sollicitudin libero. Vestibulum et ante a neque ultrices auctor. In hac habitasse platea dictumst. Nulla sodales elit quis augue suscipit, at aliquam dui dapibus. Nam ex tortor, auctor vel odio aliquam, egestas congue justo.\n\nMorbi vitae mauris dapibus, consectetur velit sed, hendrerit elit. Sed cursus massa a mauris commodo lobortis. Donec non sodales leo. Integer sit amet nulla a dolor mollis ultrices. Phasellus vel tortor arcu. Cras et nisl id eros interdum luctus. Integer interdum leo ac rhoncus facilisis. Proin porta, urna quis facilisis suscipit, ex erat porttitor mi, vitae rutrum lacus purus quis dolor. Nullam luctus tempor libero in maximus. Morbi sit amet libero nec nisi vehicula facilisis. Nulla non mi urna."
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.distribution = .fillEqually
        stackview.spacing = 10.0
        stackview.backgroundColor = UIColor.white
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    let favoritesView: UIView = {
        let favview = UIView()
        favview.backgroundColor = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 0.3)
        favview.layer.cornerRadius = 6
        favview.translatesAutoresizingMaskIntoConstraints = false
        return favview
    }()
    
    let favoritesImage: UIImageView = {
        let favImage = UIImageView()
        favImage.contentMode = .scaleAspectFit
        favImage.translatesAutoresizingMaskIntoConstraints = false
        if DarkMode {
            favImage.image = UIImage(named: "favorite-empty-white")
        } else {
            favImage.image = UIImage(named: "favorite-empty")
        }
        return favImage
    }()
    
    let favoritesLabel: UILabel = {
        let favLabel = UILabel()
        favLabel.text = "Aggiungi a Preferiti"
        favLabel.textAlignment = .center
        if DarkMode {
            favLabel.textColor = UIColor.white
        } else {
            favLabel.textColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
        favLabel.font = UIFont.systemFont(ofSize: 14.0)
        favLabel.translatesAutoresizingMaskIntoConstraints = false
        return favLabel
    }()
    
    let shareView: UIView = {
        let shareview = UIView()
        shareview.backgroundColor = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 0.3)
        shareview.layer.cornerRadius = 6
        shareview.translatesAutoresizingMaskIntoConstraints = false
        return shareview
    }()
    
    let shareImage: UIImageView = {
        let shareImg = UIImageView()
        shareImg.contentMode = .scaleAspectFit
        shareImg.translatesAutoresizingMaskIntoConstraints = false
        if DarkMode {
            shareImg.image = UIImage(named: "share-white")
        } else {
            shareImg.image = UIImage(named: "share")
        }
        return shareImg
    }()
    
    let shareLabel: UILabel = {
        let shareLbl = UILabel()
        shareLbl.text = "Condividi"
        shareLbl.textAlignment = .center
        if DarkMode {
            shareLbl.textColor = UIColor.white
        } else {
            shareLbl.textColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
        shareLbl.font = UIFont.systemFont(ofSize: 14.0)
        shareLbl.translatesAutoresizingMaskIntoConstraints = false
        return shareLbl
    }()
    
    let scheduleTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Orari"
        label.font = UIFont.systemFont(ofSize: 30.0, weight: .semibold)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scheduleLabel: UILabel = {
        let label = UILabel()
        label.text = "\u{2022} Lunedì: 9.00 - 13.00 | 15.00 - 19.30\n\u{2022} Martedì: 9.00 - 13.00 | 15.00 - 19.30\n\u{2022} Mercoledì: 9.00 - 13.00 | 15.00 - 19.30\n\u{2022} Giovedì: 9.00 - 13.00 | 15.00 - 19.30\n\u{2022} Venerdì: 9.00 - 13.00 | 15.00 - 19.30\n\u{2022} Sabato: 9.00 - 13.00\n\u{2022} Domenica: chiuso"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Indirizzo"
        label.font = UIFont.systemFont(ofSize: 30.0, weight: .semibold)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Via XX Settembre, 58, 31015 Conegliano TV"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.layer.cornerRadius = 10.0
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.005, 0.005)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(45.8865375, 12.296896500000003)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: false)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Birreria da Prosit"
        annotation.subtitle = "Birreria da Prosit"
        map.addAnnotation(annotation)
        map.isScrollEnabled = false
        map.isZoomEnabled = false
        map.isUserInteractionEnabled = true
        map.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToMapFS)))
        return map
    }()
    
    let mapButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.clear
        if DarkMode {
            button.layer.backgroundColor = UIColor.white.cgColor
        } else {
            button.layer.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0).cgColor
        }
        button.clipsToBounds = true
        var btnTitle = NSAttributedString()
        if DarkMode {
            btnTitle = NSAttributedString(string: ("GUARDA LA MAPPA").uppercased(), attributes: [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16, weight: .black), NSAttributedStringKey.foregroundColor : UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)])
        } else {
            btnTitle = NSAttributedString(string: ("GUARDA LA MAPPA").uppercased(), attributes: [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16, weight: .black), NSAttributedStringKey.foregroundColor : UIColor.white])
        }
        button.setAttributedTitle(btnTitle, for: .normal)
        button.layer.cornerRadius = 20
        if DarkMode {
            button.layer.shadowColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0).cgColor
        } else {
            button.layer.shadowColor = UIColor.darkGray.cgColor
        }
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func changeView(sender: UISegmentedControl) {
        print("Entrato")
        switch sender.selectedSegmentIndex {
        case 0:
            print("Sezione 1")
            if !alreadyOnePressed {
                setupFirstViews()
                alreadyOnePressed = true
                alreadyTwoPressed = false
            }
            break
        case 1:
            print("Sezione 2")
            if !alreadyTwoPressed {
                setupSecondViews()
                alreadyTwoPressed = true
                alreadyOnePressed = false
            }
            break
        default:
            print("Error")
        }
    }
    
    @objc func goToMapFS() {
        print("toccato")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIndentifier, for: indexPath) as! ImgCollectionViewCell
        
        let imgContent = UIImageView()
        imgContent.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
        imgContent.contentMode = .scaleAspectFill
        imgContent.clipsToBounds = true
        imgContent.image = UIImage(named: imageContent[indexPath.row])
        cell.addSubview(imgContent)
        
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
            if homeTapped {
                betterFrame.origin.y = startingFrame.origin.y - 64
            } else {
                betterFrame.origin.y = startingFrame.origin.y
            }
                
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
            
            if homeTapped {
                doneButton.frame = CGRect(x: self.view.frame.width - 60, y: 6, width: 60, height: 30)
            } else {
                doneButton.frame = CGRect(x: self.view.frame.width - 60, y: 70, width: 60, height: 30)
            }
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
            if homeTapped {
                betterFrame.origin.y = startingFrame.origin.y - 64
            } else {
                betterFrame.origin.y = startingFrame.origin.y
            }
            
            self.startinImage.alpha = 0
            
            blackBackgroundView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            blackBackgroundView.backgroundColor = UIColor.black
            blackBackgroundView.alpha = 0
            blackBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.zoomOutImage)))
            self.view.addSubview(blackBackgroundView)
            
            if homeTapped {
                doneButton.frame = CGRect(x: self.view.frame.width - 60, y: 6, width: 60, height: 30)
            } else {
                doneButton.frame = CGRect(x: self.view.frame.width - 60, y: 70, width: 60, height: 30)
            }
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
                if homeTapped {
                    betterFrame.origin.y = startingFrame.origin.y - 64
                } else {
                    betterFrame.origin.y = startingFrame.origin.y
                }
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
                if homeTapped {
                    betterFrame.origin.y = startingFrame.origin.y - 64
                } else {
                    betterFrame.origin.y = startingFrame.origin.y
                }
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

class ImgCollectionViewCell: UICollectionViewCell {
    /*override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageContent = UIImageView()
    
    func setupViews() {
        //backgroundColor = UIColor.blue
        imageContent.contentMode = .scaleAspectFill
        imageContent.clipsToBounds = true
        imageContent.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageContent)
        imageContent.topAnchor.constraint(equalTo: self.topAnchor)
        imageContent.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        imageContent.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        imageContent.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    }*/
}
