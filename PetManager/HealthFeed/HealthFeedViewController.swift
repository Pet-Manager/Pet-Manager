//
//  HealthFeedViewController.swift
//  PetManager
//
//  Created by Diane Nguyen on 11/28/20.
//

import UIKit
import Parse
import AlamofireImage

class HealthFeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pets = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let user = PFUser.current()
        self.pets = (user?["pets"] as? [PFObject]) ?? []
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetHealthCollectionViewCell", for: indexPath) as! PetHealthCollectionViewCell
        
        let pet = pets[indexPath.row]
        
        pet.fetchInBackground{(pet, error) in
            if error == nil {
                let name = pet?["name"] as? String
                //print(name!)
                cell.petName.text = name
            } else {
                print("name: failed")
            }
        }
        
        pet.fetchInBackground{(pet, error) in
            if error == nil {
                let petImage = pet?["image"] as! PFFileObject
                let urlString = petImage.url!
                let url = URL(string: urlString)!
         
                cell.petImage.af_setImage(withURL: url)
            } else {
                print("file: failed")
            }
        }
     
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
