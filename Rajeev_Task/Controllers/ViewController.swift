//
//  ViewController.swift
//  Rajeev_Task
//
//  Created by Gemini on 7/19/18.
//  Copyright © 2018 Gemini. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import SDWebImage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tableview = UITableView()
    var factsDataArray = NSMutableArray()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadCustomUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: Private Methods
    
    // Adding Coustom UI
    func loadCustomUI()  {
        tableview.frame = self.view.frame
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.backgroundColor = UIColor.init(red: 221.0/255.0, green:221.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        tableview.backgroundView?.backgroundColor = UIColor.init(red: 221.0/255.0, green:221.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        self.view.addSubview(tableview)
        registerTableViewNIBFiles()
        getLocaldata()
        // Delaying servicecall for one sec to check the internet.
        self.perform(#selector(serviceCall), with: nil, afterDelay: 1)
    }
    
    // Fetch the data fron DB to populate on UI
    func getLocaldata(){
        do {
            if factsDataArray.count > 0 {
                factsDataArray.removeAllObjects()
            }
            let localDB:NSArray = try
                context.fetch(Facts.fetchRequest()) as NSArray
            factsDataArray.addObjects(from:localDB as! [Any])
            self.tableview.reloadData()
        }
        catch {
            
        }
    }
    /*
     Registering the tableview cell nib classes.
     */
    func registerTableViewNIBFiles() {
        self.tableview.register(DataTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableview.register(UINib(nibName:"DataTableViewCell",bundle:Bundle.main), forCellReuseIdentifier: "cell")
    }
    // MARK: Service call
    
    /*
     This Method is used to make Service call to get the facts details
     */
    
    @objc func serviceCall()
    {
        let dataString = getTextFrom(URL.init(string:ObjectManager.sharedObjectManager().serviceURL)!)
        let responseData = dataString?.data(using: .utf8)
        let json = try! JSONSerialization.jsonObject(with: responseData!, options: .mutableContainers) as? Dictionary<String, AnyObject?>
        if let dictionaryArray = json {
            self.title = dictionaryArray["title"]! as? String
            guard let Object = dictionaryArray["rows"] as? NSArray else { return }
            self.resetAllRecords(in:"Facts")
            for factsDetails in Object {
                _ = ResponseObject.init(ResponseDictionary: factsDetails as! [String : Any])
            }
            getLocaldata()
        }
    }
    
    // Delete the available data on DB, to insert latest data into it.
    func resetAllRecords(in entity : String){
        let context = self.context
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do{
            try context.execute(deleteRequest)
            try context.save()
        }
        catch{
            print("Failed")
        }
    }
    
    func getTextFrom(_ url: URL) -> String?  {
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        print(data)
        return String(data: data, encoding: .utf8) ??
            String(data: data, encoding: .isoLatin1)
    }
    
    
    @objc func serviceCallToGetData(){
        if ObjectManager.sharedObjectManager().isInternetAvailable! {
            let headers = [
                "cache-control": "no-cache"
            ]
            let request = NSMutableURLRequest(url: NSURL(string: ObjectManager.sharedObjectManager().serviceURL)! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "GET"
            //Content-Type
            request.addValue("text/plain", forHTTPHeaderField: "Content-Type")
            request.allHTTPHeaderFields = headers
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error ?? "")
                } else {
                    _ = response as? HTTPURLResponse
                    let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    print(json ?? "")
                    print(response ?? "")
                }
            })
            dataTask.resume()
        }else {
            
        }
    }
}
extension ViewController {
    
    // MARK: TableView Datasource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factsDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell") as! DataTableViewCell
        let factsObjects = factsDataArray.object(at: indexPath.row) as! Facts
        cell.titleLabel.text = factsObjects.factsTitle
        cell.descriptionLabel.text = factsObjects.factsDescription
        cell.picture.sd_setImage(with: URL(string: factsObjects.factsImage!), placeholderImage: UIImage(named: "noImageicon"))
        return cell
    }
    // MARK: TableView Delegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
