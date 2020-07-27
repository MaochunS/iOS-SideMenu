//
//  MainMenuViewController.swift
//  SideMenu
//
//  Created by maochun on 2020/7/27.
//  Copyright © 2020 maochun. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    var itemArray = [String]()
    var selItemTxt = ""
    
    lazy var theTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x:0, y:0, width: 0, height: 0), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.estimatedRowHeight = 70
        tableView.rowHeight = 50
        tableView.allowsSelection = true
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .black
        
        tableView.layer.cornerRadius = 0
        
        self.view.addSubview(tableView)
        

        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:"MainMenuTableViewCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .black
        
        
        self.theTableView.reloadData()
    }
    
}


extension MainMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.itemArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainMenuTableViewCell", for:indexPath)
        cell.selectionStyle = .default
        cell.textLabel?.text = itemArray[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //tableView.cellForRow(at: indexPath)?.accessoryView = UIImageView(image: UIImage(named: "list_icon_check"))
       
        let cell = tableView.cellForRow(at: indexPath)
        self.selItemTxt = cell?.textLabel?.text ?? ""
        
        self.dismiss(animated: true, completion: nil)
        //self.popoverPresentationController?.delegate?.popoverPresentationControllerDidDismissPopover?(popoverPresentationController!)
    }
        
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
}

