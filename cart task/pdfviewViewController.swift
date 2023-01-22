//
//  pdfviewViewController.swift
//  cart task
//
//  Created by mac on 22/12/22.
//

import UIKit

class pdfviewViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var pfname = [String]()
    var pfprice = [Int]()
    var pfqty = [String]()
    var pftot = [Int]()
    var pftotal = String()
    var image = ["adobe","pdfscanner","pdfview","adobe"]
    var name = ["adobe reader","pdf scanner","pdf view","mipdf view"]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for:indexPath as IndexPath) as! CollectionViewCell
        cell.img.layer.cornerRadius = 31.5
        cell.img.layer.masksToBounds = true
        cell.img.image = UIImage(named: image[indexPath.row])
        cell.lbl.text = name[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pvc = storyboard.instantiateViewController(withIdentifier: "invoice") as! pdfViewController
        pvc.inname = pfname
        pvc.iprice = pfprice
        pvc.inqty = pfqty
        pvc.intot = pftot
        pvc.total = pftotal
        self.present(pvc, animated: true)
    }
    

    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var cancel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
   

}
