//
//  TeamChatroomViewController.swift
//  Spank
//
//  Created by Madushani Lekam Wasam Liyanage on 6/3/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class TeamChatroomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Team Name Here"
        tableView.delegate = self
        tableView.dataSource = self
        self.view.backgroundColor = UIColor.white
        self.setupViewHierarchy()
        self.configureConstraints()
    }
    
    func setupViewHierarchy() {
        self.view.addSubview(addButton)
    }
    
    func configureConstraints() {
        self.addButton.snp.makeConstraints { (view) in
            view.bottom.right.equalToSuperview().inset(8.0)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    private lazy var addButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "add-1"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.snp.makeConstraints({ (view) in
            view.size.equalTo(CGSize(width: 30, height: 30))
        })
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize(width: 1, height: 5)
        button.layer.shadowRadius = 2
        button.backgroundColor = .green
        button.layer.cornerRadius = 25
        //        button.addTarget(self, action: #selector(createActivityHandle), for: .touchUpInside)
        //        button.addTarget(self, action: #selector(handlePostInfoInterface), for: .touchUpInside)
        return button
    }()
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
