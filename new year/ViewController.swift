//
//  ViewController.swift
//  new year
//
//  Created by 汉子科技－MacBook Pro on 16/3/4.
//  Copyright © 2016年 汉子科技－MacBook Pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageV    : DSXSnowAnimation!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    
    func configUI(){
       
        imageV = DSXSnowAnimation()
        self.view.addSubview(imageV)
        
        let button = UIButton()
        button.frame = CGRectMake(100, 100, 30, 30)
        button.backgroundColor = UIColor.redColor()
        
        button.addTarget(self, action: #selector(ViewController.click(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    
    func click(sender:UIButton){
      
        sender.selected = !sender.selected
        
        if(sender.selected){
           imageV.start()
        }else{
           imageV.stop()
        }
     
    }
 
}

