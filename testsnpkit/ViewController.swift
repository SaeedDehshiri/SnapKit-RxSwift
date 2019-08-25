//
//  ViewController.swift
//  testsnpkit
//
//  Created by Saeed Dehshiri on 8/25/19.
//  Copyright © 2019 Saeed Dehshiri. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    var didSetupConstraints = false
    
    let view1 = UIView()
    let view2 = UIView()
    let label = UILabel()
    let tableView = UITableView()
    
    var items: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    private let disposeBag = DisposeBag()



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "CustomCell", bundle: Bundle.main), forCellReuseIdentifier: CustomCell.Identifier)
        customUI()
        addSubviewsToView()
        setupCellConfiguration()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            var beforeItems: [String] = self.items.value
            for iterator in 0..<10 {
                beforeItems.append("salam\(iterator)")
                self.items.accept(beforeItems)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            var beforeItems: [String] = self.items.value
            for iterator in 11..<21 {
                beforeItems.append("salam\(iterator)")
                self.items.accept(beforeItems)
            }
        }
        
    }
    
    func customUI() {
        label.backgroundColor = .red
        view1.backgroundColor = .yellow
        view2.backgroundColor = .green
    }
    
    func setupCellConfiguration() {
        //1
        items
            .bind(to: tableView
                .rx //2
                .items(cellIdentifier: CustomCell.Identifier,
                       cellType: CustomCell.self)) { //3
                        row, text, cell in
                        cell.configure(text: text) //4
            }
            .disposed(by: disposeBag) //5
    }

    
    func addSubviewsToView() {
        view.addSubview(label)
        view.addSubview(tableView)
        view.addSubview(view1)
        view.addSubview(view2)
        view.setNeedsUpdateConstraints()
    }
    
    
    override func updateViewConstraints() {
        
        if (!didSetupConstraints) {
            
            label.snp.makeConstraints { make in
                make.top.equalTo(navigationController?.navigationBar.snp.bottom ?? view.snp.top)
                make.right.equalToSuperview()
                make.left.equalToSuperview()
                make.height.equalTo(40)
            }
            
            
            tableView.snp.makeConstraints { (make) in
                make.top.equalTo(label.snp.bottom)
                make.right.left.bottom.equalTo(view)
            }
            
            view1.snp.makeConstraints { (make) in
                make.left.top.bottom.equalTo(label)
                make.right.equalTo(label.snp.centerX)
            }
            
            view2.snp.makeConstraints { (make) in
                make.right.top.bottom.equalTo(label)
                make.left.equalTo(view1.snp.right)
            }
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }

}
