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
    
    lazy var listTableView: UITableView = {
        
        let tableView = UITableView(frame: CGRect(x:self.view.frame.width - 25, y:60, width: 0, height: 0), style: .grouped)
        
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        //tableView.borderWidth = 1.0
        tableView.backgroundColor = .white
        tableView.tableHeaderView = nil
        tableView.contentInset = UIEdgeInsets(top: -30, left: 0, bottom: 0, right: 0);
        tableView.separatorStyle = .none
        //tableView.isEditing = true
        
        //tableView.allowsMultipleSelection = true
        //tableView.roundCorners(.allCorners, radius: 2.0)
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DropdownListTableCell")
        
        tableView.layer.borderColor = UIColor(red: 0.22, green: 0.8, blue: 0.85, alpha: 1).cgColor
        tableView.layer.borderWidth = 1
        tableView.layer.masksToBounds = true
        //tableView.round(corners: [.bottomLeft, .bottomRight], radius: 5)

        //tableView.isHidden = true
        
        self.view.addSubview(tableView)
        
        /*
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: self.inputField.bottomAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: self.inputField.leftAnchor, constant: 0),
            tableView.widthAnchor.constraint(equalToConstant: self.inputField.viewwidth - 32),
            tableView.heightAnchor.constraint(equalToConstant: 300)
            
        ])
        */
        
        return tableView
    }()
    
    
    var items = [String]()
    var menuShow = false
    var selectedCellColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    var selectedIdx = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 0...3{
            items.append("Item \(i)")
        }
        
        let _ = self.menuButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.listTableView.reloadData()
    }

    @objc func menuAction(){
        
        if menuShow{
            let frame = CGRect(x:self.view.frame.width - 25, y:60, width: 0, height: 0)
            UIView.animate(withDuration: 0.5) {
                self.listTableView.frame = frame
            }
            menuShow = false
        }else{
            let frame = CGRect(x:self.view.frame.width - 25 - 150, y:60, width: 150, height: 300)
            UIView.animate(withDuration: 0.5) {
                self.listTableView.frame = frame
            }
            menuShow = true
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier:"DropdownListTableCell", for:indexPath)
        
        cell.textLabel?.text = self.items[indexPath.row]
        cell.textLabel?.textColor = .gray
        cell.backgroundColor = .white

        
        if indexPath.row == selectedIdx{
            cell.backgroundColor = self.selectedCellColor
            cell.accessoryType = .checkmark
            cell.accessoryView = UIImageView(image: UIImage(named: "list_icon_check"))
        }else{
            cell.accessoryType = .none
            cell.accessoryView = nil
        }
        
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Add a visual cue to indicate that the cell was selected.
        //self.inputField.text = items[indexPath.row]
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.cellForRow(at: indexPath)?.accessoryView = UIImageView(image: UIImage(named: "list_icon_check"))
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.cellForRow(at: indexPath)?.backgroundColor = self.selectedCellColor
        
        //self.listTableView.removeFromSuperview()
        //self.dropdownListShow = false
        menuAction()
        self.selectedIdx = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        
        let idx = IndexPath(row: selectedIdx, section: 0)
        
        tableView.cellForRow(at: idx)?.accessoryType = .none
        tableView.cellForRow(at: idx)?.accessoryView = nil
        tableView.cellForRow(at: idx)?.backgroundColor = .white
        
        return indexPath
    }
}
