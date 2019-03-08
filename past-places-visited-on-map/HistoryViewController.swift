//
//  HistoryViewController.swift
//  current-place-on-map
//
//  Created by iosuser on 7/3/2019.
//  Copyright © 2019 William French. All rights reserved.
//
import UIKit
import RealmSwift


class HistoryViewController: UIViewController {
    
    var tableView: UITableView = {
        let tableV = UITableView()
        tableV.rowHeight = 80
        tableV.translatesAutoresizingMaskIntoConstraints = false
        return tableV
    }()
    var realm: Realm!
    
    
    
    var objectsArray: Results<Item> {
        get {
            return realm.objects(Item.self).sorted(byKeyPath: "time", ascending: false)
        }
    }
    
    override func viewDidLoad() {
        print("Dgfhb")
        super.viewDidLoad()
        
        realm = try! Realm()
        
        setup()
        setupTableView()
        print(objectsArray)
        tableView.reloadData()
    }
    
    func setup() {
        view.backgroundColor = .white
        navigationItem.title = "History of Visited locations"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
    func setupTableView() {
        tableView.register(MyCell.self, forCellReuseIdentifier: MyCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyCell.reuseIdentifier, for: indexPath) as! MyCell
        let item = objectsArray[indexPath.row]
        print(item.name)
        cell.todoLabel.text = item.name
        cell.LabelAddress.text = item.address
      
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateString = dateFormatter.string(from: item.time)
          cell.timeLabel.text = dateString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = objectsArray[indexPath.row]
            
            try! self.realm.write {
                self.realm.delete(item)
            }
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}

class MyCell: UITableViewCell {
    
    static let reuseIdentifier = "cell"
    
    let LabelAddress: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let todoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    func setup() {
        self.addSubview(LabelAddress)
        self.addSubview(todoLabel)
        self.addSubview(timeLabel)
        //LabelAddress.leftAnchor.constraint(equalTo: LabelAddress.leadingAnchor).isActive = true
        //LabelAddress.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
//        todoLabel.leftAnchor.constraint(equalTo: self.rightAnchor, constant: 15).isActive = true
//        todoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        todoLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        todoLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        LabelAddress.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
    LabelAddress.topAnchor.constraint(equalTo: todoLabel.bottomAnchor).isActive = true
           timeLabel.topAnchor.constraint(equalTo: LabelAddress.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

