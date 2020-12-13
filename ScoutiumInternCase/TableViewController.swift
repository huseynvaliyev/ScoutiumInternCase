//
//  TableViewController.swift
//  ScoutiumInternCase
//
//  Created by Huseyn Valiyev on 13.12.2020.
//

import UIKit
import SDWebImage

class TableViewController: UIViewController {
    
    var dataArray: [DataStruct] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    var parser = DataParser()
    let activityIndicator = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        if parser.isLoading {
            view.addSubview(activityIndicator)
            self.activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5)
            self.activityIndicator.startAnimating()
        }
        parser.parseData { data in
            self.dataArray = data
        }
        tableView.dataSource = self
    }
    
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as! TableViewCell
        cell.labelView.text = dataArray[indexPath.row].title
        let url = "https://storage.googleapis.com/anvato-sample-dataset-nl-au-s1/life-1/\(dataArray[indexPath.row].url)"
        cell.tableImageView.sd_setImage(with: URL(string: url), completed: nil)
        if !parser.isLoading {
            self.activityIndicator.stopAnimating()
        }
        return cell
    }
}
