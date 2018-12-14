//
//  DetailInfoVC.swift
//  ListMovie
//
//  Created by Benjamin Kolosov on 13/12/2018.
//  Copyright © 2018 BK. All rights reserved.
//

import UIKit

class DetailInfoVC: UIViewController{
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var descLabel  : UILabel!
    
    //var poster : UIImage!
    var titleMovie  : String!
    var desc   : String!
    var isFavourite : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleMovie
        descLabel.text  = desc
        
        descLabel.adjustsFontSizeToFitWidth = true
        descLabel.sizeToFit()
        
        createFavouriteButton(isFavourite: isFavourite!)
        
    }
    
}


extension DetailInfoVC{
    
    func createFavouriteButton(isFavourite: Bool){
        
        let favouriteButton = UIButton(type: .custom)
        
        if isFavourite{
            let favouriteImage = UIImage(named: "favouriteFalse")
            favouriteButton.setImage(favouriteImage, for: .normal)
        }else{
            let favouriteImage = UIImage(named: "favouriteTrue")
            favouriteButton.setImage(favouriteImage, for: .normal)
        }
        
        favouriteButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        favouriteButton.addTarget(self, action: #selector(addFavouriteAction(sender:)), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: favouriteButton)
        
        self.navigationItem.setRightBarButton(barButton, animated: true)
    }
    
    @objc func addFavouriteAction(sender: UIButton){
        
        if isFavourite{
           let favouriteImage = UIImage(named: "favouriteFalse")
            sender.setImage(favouriteImage, for: .normal)
        }else{
           let favouriteImage = UIImage(named: "favouriteTrue")
            sender.setImage(favouriteImage, for: .normal)
        }
        
        print("Is Favourite = \(isFavourite!)")
        
        isFavourite = !isFavourite
        UserDefaults.standard.set(isFavourite, forKey: "favor")
        UserDefaults.standard.synchronize()
        
    }
}
