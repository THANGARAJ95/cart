//
//  pdfViewController.swift
//  cart task
//
//  Created by mac on 19/12/22.
//

import UIKit
import WebKit

class pdfViewController: UIViewController,WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var inname = [String]()
    var iprice = [Int]()
    var inqty = [String]()
    var intot = [Int]()
    var total = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        createPDF()
        // Do any additional setup after loading the view.
    }
    func createPDF() {
           
           let text = getDetails()
           
           let html = "\(text)"
           let fmt = UIMarkupTextPrintFormatter(markupText: html)
           
           // 2. Assign print formatter to UIPrintPageRenderer
           
           let render = UIPrintPageRenderer()
           render.addPrintFormatter(fmt, startingAtPageAt: 0)
           
           // 3. Assign paperRect and printableRect
           
           let page = CGRect(x: 0, y: 0, width: 595.2, height: 1000) // A4, 72 dpi
           let printable = page.insetBy(dx: 20, dy: 80)
           
           render.setValue(NSValue(cgRect: page), forKey: "paperRect")
           render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
           
           // 4. Create PDF context and draw
           
           let pdfData = NSMutableData()
           UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
           
           for i in 1...render.numberOfPages {
               UIGraphicsBeginPDFPage();
               let bounds = UIGraphicsGetPDFContextBounds()
               render.drawPage(at: i - 1, in: bounds)
           }
           
           UIGraphicsEndPDFContext();
           
           // 5. Save PDF file
           
           let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
           
           guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("PDFReport").appendingPathExtension("pdf")
           else { fatalError("Destination URL not created") }
           
           pdfData.write(toFile: "\(documentsPath)/PDFReport.pdf", atomically: true)
//           drawImageOnPDF(path: "\(documentsPath)/PDFReport.pdf")
           loadPDF(filename: "PDFReport.pdf")
       }
       //Open Pdf on web view
       func loadPDF(filename: String) {
           let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
           let url = URL(fileURLWithPath: documentsPath, isDirectory: true).appendingPathComponent(filename)
           let urlRequest = URLRequest(url: url)
           webView.load(urlRequest)
       }
       //get recorded deails in html string
       func getDetails() -> String {
           
           var text = """
   <h1>Invoice of Food Ordered</h1>
      
   <br>

   <table style="width:  100%; border-collapse: collapse;">
       <thead style="border-top: 1px solid black; border-bottom: 1px solid black;">
           <tr>
               <th style="text-align: left; font-weight: 600;"> Name </th>
               <th style="text-align: left; font-weight: 600;"> Price </th>
               <th style="text-align: left; font-weight: 600;"> Qty </th>
               <th style="text-align: left; font-weight: 600;"> Totalprice </th>
               <th style="text-align: left; font-weight: 600;">  </th>

           </tr>
       </thead>
       <tbody style="border-bottom: 1px solid black;">
   """
           for recordIndex in 0..<inname.count
    {
               
               let  name = (inname[recordIndex])
               
               let Price = iprice[recordIndex]
              let Qty = inqty[recordIndex]
               let Totalprice = intot[recordIndex]
               
               text = text + """
    <tr>
               <td>\(name)</td>
               <td>\(Price)</td>
               <td>\(Qty)</td>
                <td>\(Totalprice)</td>
           </tr>
    """
           }
           let tott = total
           let text1 = """
           <h1>TOTAL</h1>
           <th>\(tott)<th>
           """
           text = text + """
               </tbody>
               </table>
               """ + text1
           return text
       }

    

}
