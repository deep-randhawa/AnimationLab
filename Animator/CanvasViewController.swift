//
//  CanvasViewController.swift
//  Animator
//
//  Created by Deep Randhawa on 3/21/17.
//  Copyright © 2017 Deep Randhawa. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var arrow: UIImageView!
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let senderTranslation = sender.translation(in: view)
        var senderSpeed = sender.velocity(in: view)
            
        //Conditional state check
        if sender.state == .began {
            trayOC = trayView.center
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOC.x, y: trayOC.y + senderTranslation.y)
        } else if sender.state == .ended {
            if senderSpeed.y > 0 {
                UIView.animate(withDuration: 0.4, animations: {
                    self.trayView.center = self.trayDown
                })
            } else {
                UIView.animate(withDuration: 0.4, animations: {
                    self.trayView.center = self.trayUp
                })
            }
        }
    }
    
    @IBOutlet weak var trayView: UIView!
    
    // GLOBAL VARS
    var trayOC: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newFace: UIImageView!
    var newFaceOC: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 180
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        let senderTranslation = sender.translation(in: view)
        var senderImageView = sender.view as! UIImageView
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pantan(sender:)))
        
        if sender.state == .began {
            newFace = UIImageView(image: senderImageView.image)
            view.addSubview(newFace)
            newFace.center = senderImageView.center
            newFace.center.y += trayView.frame.origin.y
            newFaceOC = newFace.center
            newFace.isUserInteractionEnabled = true
            newFace.addGestureRecognizer(panGestureRecognizer)
            UIView.animate(withDuration: 0.2, animations: {
                senderImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            })
        } else if sender.state == .changed {
            newFace.center = CGPoint(x: newFaceOC.x + senderTranslation.x, y: newFaceOC.y + senderTranslation.y)
        } else if sender.state == .ended {
            UIView.animate(withDuration: 0.2, animations: {
                senderImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
    }

    func pantan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if sender.state == .began {
            newFace = sender.view as! UIImageView
            newFaceOC = newFace.center
        } else if sender.state == .changed {
             newFace.center = CGPoint(x: newFaceOC.x + translation.x, y: newFaceOC.y + translation.y)
        } else if sender.state == .ended { }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
