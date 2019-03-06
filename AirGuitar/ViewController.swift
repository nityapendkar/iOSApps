//
//  ViewController.swift
//  AVAudioUnitSamplerFrobs
//
//  Created by Gene De Lisa on 1/13/16.
//  Copyright © 2016 Gene De Lisa. All rights reserved.
//
import CoreMotion
import UIKit

class ViewController: UIViewController {
    
    var sampler1: Sampler1!
    

    
    var isAbove1 : Bool = false
    var isAbove2 : Bool = false
    var isAbove3 : Bool = false
    var isAbove4 : Bool = false
    var isAbove5 : Bool = false
    var isAbove6 : Bool = false
    var withVelocity: UInt8 = 0
    var y=0
    
    // Class vars
    var rotationRate: CMRotationRate?
    var x = 0
  
    var z = 0
    let motionManager = CMMotionManager() // Create motionManager instance
    
    var pitch = 0
    var attitude: CMAttitude?
    var roll = 0
    var yaw = 0
  //  let motionManager = CMMotionManager() // Create motionManager instance
    
    // Func to get degrees from a double - use if you want to do something like if your user lifts up device (see below)
    func degrees(radians:Double) -> Double {
        return 180 / .pi * radians
    }
    
    func checkYawPitchRoll(deviceMotion:CMDeviceMotion) {
        attitude = deviceMotion.attitude
        roll = Int(degrees(radians: attitude!.roll))
        yaw = Int(degrees(radians: attitude!.yaw))
        pitch = Int(degrees(radians: attitude!.pitch))
        //print("Yaw: \(yaw) Pitch: \(pitch) Roll: \(roll)")
    }
    
    
    func updateDeviceMotions() {
        motionManager.deviceMotionUpdateInterval = 0.01 //  Change to whatever suits your app - milli-seconds
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {
            (deviceMotion, error) -> Void in
            if(error == nil) {
                self.checkYawPitchRoll(deviceMotion: deviceMotion!)
            } else {
                // Do something if theres an error
            }
        
        })
            motionManager.startGyroUpdates(to: OperationQueue.current!, withHandler: {
                (gyro, error) -> Void in
                if(error == nil) {
                    self.checkRotationVelocity(gyro: gyro!)
                } else {
                    // Do something if theres an error
                }
            })
    }
    // Func to get degrees from a double - use if you want to do something like if your user lifts up device (see below)
//    func degrees(radians:Double) -> Double {
//        return 180 / .pi * radians
//    }
    
    func checkRotationVelocity(gyro: CMGyroData) {
        rotationRate = gyro.rotationRate
        x = Int(degrees(radians: (rotationRate?.x)!))
        y = Int(degrees(radians: (rotationRate?.y)!))
        z = Int(degrees(radians: (rotationRate?.z)!))
      //  print("x: \(x) y: \(y) z: \(z)")
    }
    
    
//    func updateDeviceMotions() {
//        motionManager.deviceMotionUpdateInterval = 0.01 //  Change to whatever suits your app - milli-seconds
//        motionManager.startGyroUpdates(to: OperationQueue.current!, withHandler: {
//            (gyro, error) -> Void in
//            if(error == nil) {
//                self.checkRotationVelocity(gyro: gyro!)
//            } else {
//                // Do something if theres an error
//            }
//        })
//    }
    override func viewDidLoad(){
        super.viewDidLoad()
        
        sampler1=Sampler1()
        updateDeviceMotions()
        
        let queue = DispatchQueue(label: "strumListener")
        
        queue.async {
            while(true){
            usleep(10000)
            self.withVelocity = UInt8(abs(self.y)/10)
           // print(self.withVelocity)
            
                
                if((self.roll < 25 && self.isAbove1) || (self.roll > 25 && !self.isAbove1 )){
                    self.isAbove1 = !self.isAbove1
                    if self.withVelocity > 0{
                        self.sampler1.play(note: 40, velocity: self.withVelocity)
                        print("note 1")
                    }
                }
               else if((self.roll < 15 && self.isAbove2) || (self.roll > 15 && !self.isAbove2 )){
                    self.isAbove2 = !self.isAbove2
                    if self.withVelocity > 0{
                        self.sampler1.play(note: 47, velocity: self.withVelocity)
                        print("note 2")
                    }
                }
                if((self.roll < 5 && self.isAbove3) || (self.roll > 5 && !self.isAbove3 )){
                    self.isAbove3 = !self.isAbove3
                    if self.withVelocity > 0{
                        self.sampler1.play(note: 52, velocity: self.withVelocity)
                        print("note 3")
                    }
                }
                if((self.roll < -5 && self.isAbove4) || (self.roll > -5 && !self.isAbove4 )){
                    self.isAbove4 = !self.isAbove4
                    if self.withVelocity > 0{
                        self.sampler1.play(note: 56, velocity: self.withVelocity)
                        print("note 4")
                    }
                }
                if((self.roll < -15 && self.isAbove5) || (self.roll > -15 && !self.isAbove5 )){
                    self.isAbove5 = !self.isAbove5
                    if self.withVelocity > 0{
                        self.sampler1.play(note: 59, velocity: self.withVelocity)
                        print("note 5")
                    }
                }
                if((self.roll < -25 && self.isAbove6) || (self.roll > -25 && !self.isAbove6 )){
                    self.isAbove6 = !self.isAbove6
                    if self.withVelocity > 0{
                        self.sampler1.play(note: 64, velocity: self.withVelocity)
                        print("note 6")
                    }
                }
            }
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    @IBAction func sampler1Down(_ sender: UIButton) {
//        sampler1.play(a: 40)
//    }
//
//    @IBAction func Sampler2(_ sender: UIButton) {
//        sampler1.play(a: 47)
//    }
//    @IBAction func Sampler3(_ sender: UIButton) {
//        sampler1.play(a: 52)
//    }
//    @IBAction func Sampler4(_ sender: UIButton) {
//        sampler1.play(a: 56)
//    }
//    @IBAction func Sampler5(_ sender: UIButton) {
//        sampler1.play(a: 59)
//    }
//    @IBAction func Sampler6(_ sender: UIButton) {
//        sampler1.play(a: 64)
//    }
    //@IBAction func sampler1Up(_ sender: UIButton) {
    //    sampler1.stop()
    //}
    
  
}

