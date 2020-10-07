//
//  ViewController.swift
//  SideMenu
//
//  Created by maochun on 2020/7/24.
//  Copyright © 2020 maochun. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    lazy var menuButton:  UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 22)
        btn.setTitleColor(UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1), for: .normal)
        btn.setTitleColor(UIColor.white, for: .disabled)
        btn.setTitle(NSLocalizedString("Menu", comment: ""), for: .normal)
        //btn.setBackgroundColor(UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), for:.disabled)
        btn.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
        
    
        self.view.addSubview(btn)
        
        NSLayoutConstraint.activate([
            
            btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            btn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20)
           
            
        ])
       
        return btn
    }()
    
    lazy var popMenuButton:  UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 22)
        btn.setTitleColor(UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1), for: .normal)
        btn.setTitleColor(UIColor.white, for: .disabled)
        btn.setTitle(NSLocalizedString("PopMenu", comment: ""), for: .normal)
        //btn.setBackgroundColor(UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), for:.disabled)
        btn.addTarget(self, action: #selector(popMenuAction), for: .touchUpInside)
        
    
        self.view.addSubview(btn)
        
        NSLayoutConstraint.activate([
            
            btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 90),
            btn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20)
           
            
        ])
       
        return btn
    }()
    
    lazy var listMenu : MainMenuView = {
        let theView = MainMenuView(frame: CGRect(x:self.view.frame.width - 25, y:60, width:0, height: 0))
        theView.menuDelegate = self
        self.view.addSubview(theView)
        return theView
    }()
    

    
    var menuShow = false


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var items = [String]()
        
        for i in 0...3{
            items.append("Item \(i)")
        }
        
        self.listMenu.setup(items: items)
        
        let _ = self.menuButton
        let _ = self.popMenuButton
        
    }
    

    @objc func menuAction(){
        
        if menuShow{
            let frame = CGRect(x:self.view.frame.width - 25, y:60, width: 0, height: 0)
            UIView.animate(withDuration: 0.5) {
                self.listMenu.frame = frame
                self.listMenu.layoutSubviews()
            }
            
        }else{
            let frame = CGRect(x:self.view.frame.width - 25 - 150, y:60, width: 150, height: 300)
            UIView.animate(withDuration: 0.5) {
                self.listMenu.frame = frame
                self.listMenu.layoutSubviews()
            }
            self.view.bringSubviewToFront(self.listMenu)
        }
        
        menuShow = !menuShow
    }
    
    @objc func popMenuAction(){
        
        let vc = MainMenuViewController()
        for i in 0...5{
            vc.itemArray.append("item \(i)")
        }
        
        
        var vcHeight = 50 * vc.itemArray.count + 10
        if vcHeight > 220{
            vcHeight = 220
        }
        vc.preferredContentSize = CGSize(width: 220, height: vcHeight)
        vc.modalPresentationStyle = UIModalPresentationStyle.popover
        //vc.delegate = self
        
        let popoverPresentationController = vc.popoverPresentationController
        popoverPresentationController?.sourceView = self.popMenuButton
        popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: UIPopoverArrowDirection.up.rawValue) // UIPopoverArrowDirection(rawValue: 0)
        //popoverPresentationController?.sourceRect = CGRect(x: (self.topViewController?.view)!.frame.width-180, y: 110, width: 200, height: 10)
        popoverPresentationController?.delegate = self
        popoverPresentationController?.backgroundColor = .clear

        self.present(vc, animated: true, completion: nil)
    }

}

extension ViewController: UIPopoverPresentationControllerDelegate{
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController){
        print("popup menu dismissed")
        
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

extension ViewController: MainMenuViewDelegate{
    func didSelectMenuItem(idx: Int) {
        self.menuAction()
    }
    
    
}
