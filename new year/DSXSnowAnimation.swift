//
//  DSXSnowAnimation.swift
//  new year
//
//  Created by 汉子科技－MacBook Pro on 16/3/4.
//  Copyright © 2016年 汉子科技－MacBook Pro. All rights reserved.
//

import UIKit

class DSXSnowAnimation: UIImageView {
    
    var fireworksEmitter:CAEmitterLayer!

    /**
     *  开始下雪和放烟花
     *
     *  @return
     */
    func start(){//llll
      
        self.image = UIImage.init(named: "news.bundle/background.jpg")
        self.frame = UIScreen.mainScreen().bounds
        
        //雪花
        let snowEmitter:CAEmitterLayer = CAEmitterLayer()
        snowEmitter.emitterPosition = CGPointMake(self.bounds.size.width / 2.0, -30)
        snowEmitter.emitterSize		= CGSizeMake(self.bounds.size.width * 2.0, 0.0)
        
        snowEmitter.emitterMode		= kCAEmitterLayerOutline
        snowEmitter.emitterShape	= kCAEmitterLayerLine
        
        let snowflake:CAEmitterCell = CAEmitterCell()
        //随机颗粒的大小
        snowflake.scale = 0.2;
        snowflake.scaleRange = 0.5;
        
        
        //缩放比列速度
        //snowflake.scaleSpeed = 0.1
        
        //粒子参数的速度乘数因子；
        snowflake.birthRate	= 20.0
        
        //生命周期
        snowflake.lifetime  = 60.0
        
        //粒子速度 下落
        snowflake.velocity		= 20
        snowflake.velocityRange = 10
        
        //粒子y方向的加速度分量
        snowflake.yAcceleration = 2;
        
        //周围发射角度
        snowflake.emissionRange = 0.5  * CGFloat(M_PI)// some variation in angle
        //自动旋转
        snowflake.spinRange		= 0.25 * CGFloat(M_PI)// slow spin
        
        
        snowflake.contents =  UIImage.init(named: "news.bundle/fire")?.CGImage
        snowflake.color	=  UIColor.init(colorLiteralRed: 0.6, green: 0.658, blue: 0.743, alpha: 1).CGColor
        
        // Make the flakes seem inset in the background
        snowEmitter.shadowOpacity = 1.0;
        snowEmitter.shadowRadius  = 0.0;
        snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
        snowEmitter.shadowColor   =  UIColor.whiteColor().CGColor
        
        // Add everything to our backing layer below the UIContol defined in the storyboard
        snowEmitter.emitterCells = [snowflake];
        self.layer.addSublayer(snowEmitter)
        
        // Cells spawn in the bottom, moving up
        fireworksEmitter = CAEmitterLayer()
        let viewBounds:CGRect = self.layer.bounds
        
        fireworksEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height)
        fireworksEmitter.emitterSize	= CGSizeMake(viewBounds.size.width/2.0, 0.0)
        fireworksEmitter.emitterMode	= kCAEmitterLayerOutline
        fireworksEmitter.emitterShape	= kCAEmitterLayerLine
        fireworksEmitter.renderMode		= kCAEmitterLayerAdditive
        fireworksEmitter.seed = (arc4random()%100)+1
        
        // Create the rocket
        let rocket:CAEmitterCell = CAEmitterCell()
        
        rocket.birthRate		= 5.0
        rocket.emissionRange	= 0.25 * CGFloat(M_PI) // some variation in angle
        rocket.velocity			= 380
        rocket.velocityRange	= 380
        rocket.yAcceleration	= 75
        rocket.lifetime			= 1.02	//we cannot set the birthrate < 1.0 for the burst
        
        rocket.contents			= UIImage.init(named: "news.bundle/ball")?.CGImage
        rocket.scale			= 0.2
        //rocket.color
        rocket.greenRange		= 1.0  //different colors
        rocket.redRange			= 1.0
        rocket.blueRange		= 1.0
        rocket.spinRange		= CGFloat(M_PI) // slow spin
        
        // the burst object cannot be seen, but will spawn the sparks
        // we change the color here, since the sparks inherit its value
        let burst:CAEmitterCell = CAEmitterCell()
        
        burst.birthRate			= 1.0	// at the end of travel
        burst.velocity			= 0
        burst.scale				= 2.5
        burst.redSpeed			= -1.5	// shifting
        burst.blueSpeed			= +1.5	// shifting
        burst.greenSpeed		= +1.0	// shifting
        burst.lifetime			= 0.35
        
        
        // and finally, the sparks
        let spark:CAEmitterCell = CAEmitterCell()
        
        spark.birthRate			= 400
        spark.velocity			= 125
        spark.emissionRange		= 2 * CGFloat(M_PI)	// 360 deg
        spark.yAcceleration		= 75		// gravity
        spark.lifetime			= 3
        
        spark.contents			= UIImage.init(named: "news.bundle/fire")?.CGImage
        spark.scale		        = 0.5
        spark.scaleSpeed		= -0.2
        spark.greenSpeed		= -0.1
        spark.redSpeed			= 0.4
        spark.blueSpeed			= -0.1
        spark.alphaSpeed		= -0.5
        spark.spin				= 2 * CGFloat(M_PI)
        spark.spinRange			= 2 * CGFloat(M_PI)
        
        // putting it together
        fireworksEmitter.emitterCells	= [rocket]
        rocket.emitterCells				= [burst]
        burst.emitterCells				= [spark]
        self.layer.addSublayer(fireworksEmitter)
    }
    
    /**
     *  停止下雪和放烟花
     *
     *  @return
     */
    func stop(){
       self.layer.sublayers?.removeAll()
       fireworksEmitter.removeFromSuperlayer()
       fireworksEmitter = nil
    }
    
    /**
    *  设置背景图
    */
    func background(image:UIImage){
      self.image = image
    }
}
