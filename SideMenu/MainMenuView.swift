//
//  MainMenuView.swift
//  SideMenu
//
//  Created by maochun on 2020/10/7.
//  Copyright © 2020 maochun. All rights reserved.
//

import UIKit

protocol MainMenuViewDelegate {
    func didSelectMenuItem(idx: Int)
    func didTapTheView()
}


class MainMenuView: UIView {
    
    
    lazy var listTableView: UITableView = {
        
        let tableView = UITableView(frame: CGRect.zero, style: .grouped) //UITableView(frame: self.frame, style: .grouped)
        //let tableView = UITableView(frame: self.frame, style: .grouped)
        
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
        
        self.addSubview(tableView)
        
        
        /*
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor)
            
        ])
        */
        
        
        return tableView
    }()
    
    var items = [String]()
   
    var selectedCellColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    var selectedIdx = 0
    
    var menuDelegate:MainMenuViewDelegate?
    
    func setup(items: [String], menuStartRect:CGRect){
        self.items.append(contentsOf: items)
        self.listTableView.frame = menuStartRect
        self.listTableView.reloadData()
    }

    func show(flag:Bool, frame: CGRect){
        UIView.animate(withDuration: 0.5) {
            self.listTableView.frame = frame
        }
    }
    
    @objc func onTapped(){
        self.menuDelegate?.didTapTheView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapped))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension MainMenuView: UITableViewDelegate, UITableViewDataSource {
    
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
        
        self.menuDelegate?.didSelectMenuItem(idx: indexPath.row)
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


extension MainMenuView: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        var view = touch.view
        while view != nil {
            if view is UITableView {
                return false
            } else {
                view = view!.superview
            }
        }
        return true
    }
}
