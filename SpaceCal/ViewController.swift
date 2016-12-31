//
//  ViewController.swift
//  SpaceCal
//
//  Created by Estique on 12/31/16.
//  Copyright © 2016 Estique. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!
    var mathSound : AVAudioPlayer!
    var runningNumber:String = ""
    var currentOperation = Operations.Empty
    var leftValStr = ""
    var rightVarStr = ""
    var result = ""
    
    enum Operations:String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }

    @IBOutlet var outputLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path1 = Bundle.main().pathForResource("btn", ofType: "wav")
        let soundURL1 = URL(fileURLWithPath: path1!)
        let path2 = Bundle.main().pathForResource("sound", ofType: "wav")
        let soundURL2 = URL(fileURLWithPath: path2!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundURL1)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
        do{
            try mathSound = AVAudioPlayer(contentsOf: soundURL2)
            mathSound.prepareToPlay()
        }catch(let err as NSError){
            print(err.debugDescription)
        }
        
        outputLable.text = "0"
    }
    
    @IBAction func numberPressed(sender:UIButton){
        playSOund1()
        runningNumber = runningNumber + "\(sender.tag)"
        outputLable.text = runningNumber
        
    }
    
    @IBAction func mathSignPressed(sender:UIButton){
        playSound2()
    }
    
    @IBAction func onDividePressed(sender : AnyObject){
        processOperation(operation: .Divide)
    }
    @IBAction func onMUltiplyPressed(sender : AnyObject){
        processOperation(operation: .Multiply)
    }
    @IBAction func onSubtractPressed(sender : AnyObject){
        processOperation(operation: .Subtract)
    }
    @IBAction func onAddPressed(sender : AnyObject){
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender : AnyObject){
        processOperation(operation: currentOperation)
    }
    
    
    @IBAction func btnClear(_ sender: AnyObject) {
        runningNumber = ""
        currentOperation = Operations.Empty
        leftValStr = ""
        rightVarStr = ""
        result = ""
        
        outputLable.text = "0"
    }
    
    
    func playSOund1(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func playSound2(){
        if mathSound.isPlaying{
            mathSound.stop()
        }
        mathSound.play()
    }
    
    func processOperation(operation: Operations){
        
        if currentOperation != Operations.Empty{
            
            if runningNumber != ""{
                rightVarStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operations.Divide{
                    result = "\(Double(leftValStr)! / Double(rightVarStr)!)"
                }else if currentOperation == Operations.Multiply{
                   result = "\(Double(leftValStr)! * Double(rightVarStr)!)"
                }else if currentOperation == Operations.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightVarStr)!)"
                }else if currentOperation == Operations.Add{
                  result = "\(Double(leftValStr)! + Double(rightVarStr)!)"
                }
                
                leftValStr = result
                outputLable.text = result
        }
            
            currentOperation = operation
        }else{
            //this is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
    }
    



}

