//
//  SettingsViewController.swift
//  Treviso4Tourists
//
//  Created by Administrator on 27/06/18.
//  Copyright © 2018 Edoardo Scarpel. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var settingSuperview: UIView!
    @IBOutlet weak var lineAfterTtitle: UIView!
    @IBOutlet weak var titleOne: UILabel!
    @IBOutlet weak var darkLabel: UILabel!
    @IBOutlet weak var switchDarkMode: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Settings"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let iconImg = UIImageView()
        iconImg.frame = CGRect(x: UIScreen.main.bounds.width - 80, y: 64, width: 60, height: 60)
        iconImg.image = UIImage(named: "settings-5")
        view.addSubview(iconImg)
        
        inOther = true
        
        if DarkMode {
            switchDarkMode.setOn(true, animated: true)
        } else {
            switchDarkMode.setOn(false, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        inOther = true
        self.title = "Settings"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        if DarkMode {
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)]
            self.navigationController?.navigationBar.tintColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0) 
            UIApplication.shared.statusBarStyle = .lightContent
            settingSuperview.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            lineAfterTtitle.backgroundColor = UIColor(red: 126.0/255.0, green: 136.0/255.0, blue: 137.0/255.0, alpha: 1.0)
            titleOne.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            darkLabel.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)

        } else {
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.black]
            self.navigationController?.navigationBar.tintColor = UIColor.black
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
            settingSuperview.backgroundColor = UIColor.white
            lineAfterTtitle.backgroundColor = UIColor.darkGray
            titleOne.textColor = UIColor.black
            darkLabel.textColor = UIColor.black
        }
    }
    
    @IBAction func DarkModeChanged(_ sender: UISwitch) {
        if sender.isOn {
            DarkMode = true
            print("Switch is on")
            UserDefaults.standard.set(DarkMode, forKey: "darkmode")
            changeMode()
        } else {
            DarkMode = false
            print("Switch is off")
            UserDefaults.standard.set(DarkMode, forKey: "darkmode")
            changeMode()
        }
    }
    
    func changeMode() {
        if DarkMode {
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)]
            self.navigationController?.navigationBar.tintColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            UIApplication.shared.statusBarStyle = .lightContent
            settingSuperview.backgroundColor = UIColor(red: 20.0/255.0, green: 38.0/255.0, blue: 52.0/255.0, alpha: 1.0)
            lineAfterTtitle.backgroundColor = UIColor(red: 126.0/255.0, green: 136.0/255.0, blue: 137.0/255.0, alpha: 1.0)
            titleOne.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            darkLabel.textColor = UIColor(red: 189.0/255.0, green: 199.0/255.0, blue: 193.0/255.0, alpha: 1.0)
            
        } else {
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.black]
            self.navigationController?.navigationBar.tintColor = UIColor.black
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
            settingSuperview.backgroundColor = UIColor.white
            lineAfterTtitle.backgroundColor = UIColor.darkGray
            titleOne.textColor = UIColor.black
            darkLabel.textColor = UIColor.black
        }
    }

}
