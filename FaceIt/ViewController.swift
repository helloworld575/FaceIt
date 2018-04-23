//
//  ViewController.swift
//  FaceIt
//
//  Created by HealthJudge on 2018/4/13.
//  Copyright © 2018年 HealthHIT. All rights reserved.
//

import UIKit
@objcMembers
class ViewController: UIViewController {
    
    @IBOutlet weak var myFaceView: FaceView!{
        didSet{
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: myFaceView,action:handler)
            myFaceView.addGestureRecognizer(pinchRecognizer)
            let tapRecognizer = UITapGestureRecognizer(target:self,action:#selector(toggleEyes(byReactingTo:)))
            tapRecognizer.numberOfTapsRequired = 1
            myFaceView.addGestureRecognizer(tapRecognizer)
            let swipeUpRecognizer = UISwipeGestureRecognizer(target:self,action:#selector(increaseHappiness))
            swipeUpRecognizer.direction = .up
            myFaceView.addGestureRecognizer(swipeUpRecognizer)
            let swipeDownRecognizer = UISwipeGestureRecognizer(target:self,action:#selector(decreseHappiness))
            swipeDownRecognizer.direction = .down
            myFaceView.addGestureRecognizer(swipeDownRecognizer)
            updateUI()
        }
    }
    
    func increaseHappiness(){
        expression = expression.happier
    }
    
    func decreseHappiness(){
        expression = expression.sadder
    }
    
    func toggleEyes(byReactingTo tapRecongnizer:UITapGestureRecognizer){
        if tapRecongnizer.state == .ended{
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            expression = FacialExpression(eyes:eyes,mouth:expression.mouth)
        }
    }
    
    var expression = FacialExpression(eyes: .open,mouth: .grin){
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        switch expression.eyes{
        case .open:
            myFaceView?.eyeOpen = true
        case .closed:
            myFaceView?.eyeOpen = false
        case .squinting:
            myFaceView?.eyeOpen = false
        }
        myFaceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    private let mouthCurvatures = [FacialExpression.Mouth.grin:0.5,.frown:-1.0,.smile:1.0,.neutral:0.0,.smirk:-0.5]
    
}

