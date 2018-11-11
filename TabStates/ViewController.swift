//ViewController.swift
/*
 * TabStates
 * Created by penumutchu.prasad@gmail.com on 11/11/18
 * Is a product created by abnboys
 * For the  in the TabStates
 
 * Here the permission is granted to this file with free of use anywhere in the IOS Projects.
 * Copyright © 2018 ABNBoys.com All rights reserved.
*/

import UIKit

class ViewController: UIViewController {
   
    typealias TableItem = String
    
    @IBOutlet var spinner: UIActivityIndicatorView!

    @IBOutlet var tableView: StatusfulTableView!
    let cellId = "UITableViewCell"
    
    var names = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.bringSubviewToFront(spinner)
        spinner.startAnimating()
        
//        loadData()
    }

    private func loadData() {
        
        tableView.setState(.Loading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tableView.setState(.NoItems)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.tableView.setState(.Success)
            self.names = Array.init(repeating: "Krish", count: 35)
            self.spinner.stopAnimating()
        }
        
    }
    
    @IBAction func dfdgdfhsj(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            tableView.setState(.Loading)
        case 1:
            tableView.setState(.Failed)
        case 2:
            tableView.setState(.NoItems)
        default:
            tableView.setState(.Success)
            loadData()

        }
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = names[indexPath.row]
        
        return cell
        
    }
    
}
