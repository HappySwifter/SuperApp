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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        socket.on("joinResult") {data, ack in
            print("joinResult")
        }
        

        
        socket.connect()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

