//
//  cartViewController.swift
//  cart task
//
//  Created by mac on 17/12/22.
//

import UIKit
protocol passdatatovc{
    func passdata(str1:Int)
}

class cartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var delegate:passdatatovc!
    var passname = [String]()
    var passprice = [Int]()
    var passimg = [String]()
    var quantity = [String]()
    var priceitem = [Int]()
    
    var sum = 0
    
    @IBOutlet weak var tableview1: UITableView!
    
    @IBOutlet weak var total: UILabel!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        priceitem = passprice
//        sum = priceitem.reduce(0, +)
//        total.text = "\(sum)"
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passname.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cartTableViewCell
        
        cell.lbll1.text = passname[indexPath.row]
        
        let price = passprice[indexPath.row]
        let qty = Int(quantity[indexPath.row])!
        let lbprice = (price * qty)
       
        cell.quantity.text = quantity[indexPath.row]
        cell.lbll2.text = "\(lbprice)"
        
        priceitem.remove(at: indexPath.row)
        priceitem.insert(lbprice, at: indexPath.row)
        sum = priceitem.reduce(0, +)
        total.text = "Rs.\(sum)"
        cell.imgg.image = UIImage(named: passimg[indexPath.row])
        cell.remove.tag = indexPath.row
        cell.remove.addTarget(self, action: #selector(butact), for: .touchUpInside)
        cell.stepp.tag = indexPath.row
        cell.stepp.addTarget(self, action: #selector(stepact), for: .valueChanged)
        return cell
    }
    @objc func butact(sender:UIButton!){
        passname.remove(at: sender.tag)
        passprice.remove(at: sender.tag)
        passimg.remove(at: sender.tag)
        quantity.remove(at: sender.tag)
        priceitem.remove(at: sender.tag)
        sum = 0
        total.text = "Rs.0"
        tableview1.reloadData()
        delegate.passdata(str1: sender.tag)
    }
    @objc func stepact(sender:UIStepper!){
        quantity.remove(at: sender.tag)
        let qty = Int(sender.value)
        quantity.insert("\(qty)", at: sender.tag)
//        price = (lbprice * qty)
        
        sum = 0
       tableview1.reloadData()
    
    }
    
    @IBAction func invoice(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "pdffile") as! pdfviewViewController
        ivc.pfname = passname
        ivc.pfprice = passprice
        ivc.pfqty = quantity
        ivc.pftot = priceitem
        ivc.pftotal = total.text!
        
                if let presentationController = ivc.presentationController as? UISheetPresentationController {
                            presentationController.detents = [.medium()] /// change to [.medium(), .large()] for a half *and* full screen sheet
                        }
        
        self.present(ivc, animated: true)
        
    }
    
    
}
