//
//  ViewController.swift
//  cart task
//
//  Created by mac on 16/12/22.
//

import UIKit
struct product {
    var name:String?
    var price:Int?
    var image:String?
}
 

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    var food = [product(name: "Idli",price: 20,image: "idlie"),product(name: "Dosa",price: 35,image: "dosa"),product(name: "Chapathi",price: 30,image: "chapathi"),product(name: "Parotta",price: 30,image: "parota"),product(name: "Meals",price: 75,image: "meals"),product(name: "Chicken Briyani",price: 100,image: "chickenbriyani"),product(name: "Mutton Briyani",price: 130,image: "muttonbriyani"),product(name: "Omelette",price: 15,image: "omelette"),product(name: "Chicken Rice",price: 120,image: "chickenrice"),product(name: "Chicken Noodles",price: 120,image: "chickennoodles")]
    
    // MARK: Outlets
    
    @IBOutlet weak var addedvalue: UILabel!
   
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var view1: UIView!
    
    // MARK: variables

    var qtyy = [String]()
    var filter : [product] = []
    
    var cartname = [String]()
    var cartprice = [Int]()
    var cartimage = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addedvalue.layer.cornerRadius = 10
        addedvalue.layer.masksToBounds = true
        addedvalue.isHidden = true
        addedvalue.text = ""
        filter = food

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         if(searchbar.text == ""){
           filter = food
            
        }
        else{
//            filter = product.name!.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
            filter = food.filter({ value -> Bool in
                        guard let text =  searchBar.text else { return false}
                return value.name!.contains(text) // According to title from JSON

                    })
        }
        tableview.reloadData()
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! TableViewCell
        cell.view1.layer.cornerRadius = 10
        cell.view1.layer.borderWidth = 2
        cell.view1.layer.borderColor = UIColor.blue.cgColor
        cell.lbl1.text = filter[indexPath.row].name
        cell.lbl2.text = "Rs."+"\(filter[indexPath.row].price!)"
        cell.img.image = UIImage(named: filter[indexPath.row].image!)
        cell.but.tag = indexPath.row
        cell.but.addTarget(self, action: #selector(buttonaction), for: .touchUpInside)
       
        return cell
    }
    @objc func buttonaction(sender: UIButton!){
        if(cartname.contains(filter[sender.tag].name!)){
            self.showToast(message: "ALLREADY IN CART", font: .systemFont(ofSize: 12.0))
        }
        else {
            cartname.append(filter[sender.tag].name!)
            cartprice.append(filter[sender.tag].price!)
            cartimage.append(filter[sender.tag].image!)
            qtyy.append("1")
            addedvalue.isHidden = false
            addedvalue.text = "\(cartname.count)"
            self.showToast(message: "ADD TO CART", font: .systemFont(ofSize: 12.0))
        }
    }
    
    @IBAction func passbut(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "cart") as! cartViewController
        vc.passname = cartname
        vc.passprice = cartprice
        vc.passimg = cartimage
        vc.quantity = qtyy
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    }
extension ViewController:passdatatovc{
    func passdata(str1: Int) {
        cartname.remove(at: str1)
        cartprice.remove(at: str1)
        cartimage.remove(at: str1)
        qtyy.remove(at: str1)
        
        if(cartname.count) == 0{
            addedvalue.isHidden = true
            addedvalue.text = ""
        }
        else {
            addedvalue.isHidden = false
            addedvalue.text = "\(cartname.count)"
        }
    }
    
    
}

extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 2.0, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
