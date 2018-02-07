//
//  FourthViewController.swift
//  DinoSource
//
//  Created by Kenneth on 11/22/16.
//  Copyright © 2016 Kenneth_SSD. All rights reserved.
//

import UIKit
//list view
class FourthViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    var caughtKeys:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = "List View"
        
        self.view.backgroundColor = UIColor(red: 239/255, green: 232/255, blue: 229/255, alpha: 1)

        
        updateData()
        
        tableView.frame = CGRect(x: 0, y:0, width:view.bounds.width, height: view.bounds.height)
        tableView.backgroundColor = UIColor(red: 239/255, green: 232/255, blue: 229/255, alpha: 1)

        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
                
        
    }
    
      func updateData() {
        caughtKeys = PlistManager.sharedInstance.getCaughtKeys()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.dataArray.count
        //return self.dataDictionary.count
        
        return caughtKeys.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell()
            cell.textLabel?.text = caughtKeys[indexPath.row]
            cell.textLabel?.textColor = UIColor(red: 170/255, green: 200/255, blue: 107/255, alpha: 1)
            cell.textLabel?.font = UIFont(name: "Noteworthy", size: 18)
            cell.backgroundColor = UIColor(red: 239/255, green: 232/255, blue: 229/255, alpha: 1)
        //cell.imageView?.image = UIImage(cgImage: #imageLiteral(resourceName: "Camera") as! CGImage)
        //cell.textLabel?.text = self.keys[indexPath.row]
        return cell
    }
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        /*print("\(indexPath.row) was clicked")
         keys.insert("fish", at: dataDictionary.count)
         tableView.reloadData()*/
        
        //      let clickedKey = keys[indexPath.row]
        //    print("\(clickedKey) was clicked and is of type\(dataDictionary[clickedKey]!["type"]!)")
        print(caughtKeys[indexPath.row])
        //make the detail and pass it the value we are printing above.
        showDetailPage(chosenKey: caughtKeys[indexPath.row])
    }
    func showDetailPage(chosenKey:String){
        let list = ThirdViewController()
        list.loadData(forKey:chosenKey)
        navigationController?.pushViewController(list, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

