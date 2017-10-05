//
//  ViewController.swift
//  Magical Grid
//
//  Created by George Garcia on 10/4/17.
//  Copyright © 2017 G Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let numViewPerRow = 15
    
    var cells = [String: UIView]() // creating a dictionary for a hash map view

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //render and to put in an amount of boxes of the width of the device
        let width = view.frame.width / CGFloat(numViewPerRow)
        
        //another for loop so we can add boxes vertically
        
        for j in 0...30 {
            for i in 0...numViewPerRow{
                //print(i)
                let cellView = UIView()
                cellView.backgroundColor = randomColor()
                cellView.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
                
                cellView.layer.borderWidth = 0.5
                cellView.layer.borderColor = UIColor.black.cgColor
                
                view.addSubview(cellView)
                
                let key = "\(i)|\(j)"
                cells[key] = cellView
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector (handlePan)))
        
    }
    
    fileprivate func randomColor() -> UIColor { // random colors for the boxes
        
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
        
    }
    
    var selectedCell: UIView? //optional because it will start off as nil since we haent selected anything on the grid
    
    @objc func handlePan(gesture: UIPanGestureRecognizer){
        
        let location = gesture.location(in: view)
        //print(location)
        
        // tells the console the location of the user's finger on a cell
        let width = view.frame.width / CGFloat(numViewPerRow)
        let i = Int(location.x / width)
        let j = Int(location.y / width)
        print(i,j)
        
        let key = "\(i)|\(j)"
        guard let cellView = cells[key] else {return}
        
        if selectedCell != cellView{ // going to have to keep track of the cell.
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
        
        selectedCell = cellView // when we constantly setting the selected cell to whatever the cell we are touching
        
        view.bringSubview(toFront: cellView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        
        }, completion: nil)
        
        if gesture.state == .ended{
            
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                cellView.layer.transform = CATransform3DIdentity
                
            }, completion: { (_) in
                
            })
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }

}

