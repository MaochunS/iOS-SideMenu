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
        //let theView = MainMenuView(frame: CGRect(x:self.view.frame.width - 25, y:60, width:0, height: 0))
        let theView = MainMenuView()
        theView.translatesAutoresizingMaskIntoConstraints = false
        theView.menuDelegate = self
        theView.isHidden = true
        self.view.addSubview(theView)
        
        NSLayoutConstraint.activate([
            theView.topAnchor.constraint(equalTo: self.view.topAnchor),
            theView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            theView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            theView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        
        ])
        
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
        
        let frame = CGRect(x:self.view.frame.width - 25, y:60, width: 0, height: 0)
        self.listMenu.setup(items: items, menuStartRect: frame)
        
        let _ = self.menuButton
        let _ = self.popMenuButton
        
    }
    

    @objc func menuAction(){
        
        var frame = CGRect.zero
        if menuShow{
            self.listMenu.isHidden = true
            frame = CGRect(x:self.view.frame.width - 25, y:60, width: 0, height: 0)
           
        }else{
            self.listMenu.isHidden = false
            frame = CGRect(x:self.view.frame.width - 25 - 150, y:60, width: 150, height: 300)
            
            self.view.bringSubviewToFront(self.listMenu)
        }
        
        
        
        /*
        UIView.animate(withDuration: 0.5) {
            self.listMenu.frame = frame
            self.listMenu.layoutSubviews()
        }
        */
        
        menuShow = !menuShow
        
        self.listMenu.show(flag: menuShow, frame: frame)
    }
    
    @objc func popMenuAction(){
        
        let vc = MainMenuViewController()
        vc.menuDelegate = self
        
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

    
    func showMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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
        
        showMessage(title: "Select menu list item \(idx) ", message: "")
    }
    
    func didTapTheView(){
        self.menuAction()
    }
}

extension ViewController: MainMenuViewControllerDelegate{
    func didSelectPopMenuItem(idx: Int) {
        showMessage(title: "Select popup menu item \(idx) ", message: "")
    }
}
