//
//  ViewController.swift
//  Swift-CalculateCellHight
//
//  Created by huchunyuan on 15/12/6.
//  Copyright © 2015年 huchunyuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var modelArr:NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // model赋值
        loadModel()
        // 搭建tableView
        layoutTableView()
    }
    func layoutTableView(){
        // 注册Cell
        tableView.registerNib(UINib.init(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "abc")
    }
    func loadModel(){
        // 从plist重给model赋值
        let path = NSBundle.mainBundle().pathForResource("DataList", ofType: "plist")
        let dataArr = NSArray(contentsOfFile:path!)
        for d in dataArr! {
            // KVC
            let dic:Dictionary<String,String> = d as! Dictionary
            let model = Model()
            model.setValuesForKeysWithDictionary(dic)
            modelArr.addObject(model)
        }
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let model = modelArr[indexPath.row] as! Model
        
        return CGFloat(90 + model.line*20);
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("abc", forIndexPath: indexPath) as! MyCell
        let model = modelArr[indexPath.row] as! Model
        cell.titleLabel.text = model.title
        cell.writer.text = model.writer
        cell.commentLabel.text = model.comment
        return cell;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

