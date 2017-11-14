//
//  ViewController.swift
//  SwiftInfoDemo
//
//  Created by 高鑫 on 2017/11/14.
//  Copyright © 2017年 高鑫. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    var tableView = UITableView()
    var scrollView = UIScrollView()
    var titleView = UIView()
    var img = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.frame = self.view.frame
        scrollView.contentSize = CGSize(width: w, height: 2000 + w)
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        img.frame = CGRect(x: 0, y: 0, width: w, height: w)
        img.image = #imageLiteral(resourceName: "tx")
        scrollView.addSubview(img)
        
        tableView.frame = CGRect(x: 0, y: w, width: w, height: 2000)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        scrollView.addSubview(tableView)
        
        
        titleView.backgroundColor = UIColor(named: "iBlue")
        titleView.alpha = 0
        titleView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64)
        let title = UILabel()
        title.text = "演示"
        title.frame.size = CGSize(width: 200, height: 50)
        title.textAlignment = .center
        title.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        title.center.x = titleView.center.x
        title.center.y = titleView.center.y + 10
        titleView.addSubview(title)
        self.view.addSubview(titleView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + 20
        if offset <= 0 {
            let percent = (w - offset) / w
            img.frame = CGRect(x: 0, y: offset, width: w * percent, height: w * percent)
            img.center.x = w / 2
        }
        let min : CGFloat = -20
        let max : CGFloat = 84
        let alpha = (offset - 20 - min) / (max - min)
        titleView.alpha = alpha
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        var strs : [String] = []
        for i in 1...50 {
            strs.append("\(i)")
        }
        cell.demoLabel.text = strs[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

class TableViewCell: UITableViewCell {
    
    var demoLabel = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cell")
        demoLabel.frame = self.frame
        demoLabel.center.x = UIScreen.main.bounds.width / 2
        demoLabel.textAlignment = .center
        self.addSubview(demoLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
