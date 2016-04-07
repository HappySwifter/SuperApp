//
//  ViewController.swift
//  SuperAppClient
//
//  Created by Артем Валиев on 07.04.16.
//  Copyright © 2016 Артем Валиев. All rights reserved.
//

import UIKit
import SocketIOClientSwift


let socket = SocketIOClient(socketURL: NSURL(string: "http://localhost:3000")!, options: [.Log(true), .ForcePolling(true)])


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var data = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        socket.on("joinResult") {data, ack in
            print("joinResult")
        }
        
        socket.on("users") { (data, ack) in
            print(data)
            for user in data {
                if let userProp = user["properties"], let name = userProp!["name"] as? String {
                    self.data.append(name)
                }

            }
            self.tableView.reloadData()
        }
        
        socket.connect()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func reload() {
        socket.emit("getUsers", "")
    }


}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}
