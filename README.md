# Swift-CalculateCellHight
iOS-Swift-自动计算cell高度
#前言

####因为最近工作有需求要用到这个功能,但是我工程已经决定用OC写了,所以手痒写个swift版,本章博客用到很多上一篇博客的东西,还运用了一小步递归,所以有不明白的可以去看一看我的上一篇博客.

---
#上代码
####先创建一个plist写假数据
![这里写图片描述](http://img.blog.csdn.net/20151206151402619)
####然后创建一个Cell
![这里写图片描述](http://img.blog.csdn.net/20151206151422002)
####创建一个Model.swift写以下代码
```
import UIKit

class Model: NSObject {
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        return;
    }
    // 传入字符串计算行数
    func PassStringReturnIndex(str:String)->Int {
        // 比较值
        let rangeStr = "\n"
        // 比较
        let range = str.rangeOfString(rangeStr)
        // 如果有结果
        if range != nil {
            // 行数+1
            line++
            // 从比较结尾进行切割字符串
            let str2 = str.substringFromIndex(range!.endIndex)
            // 递归调用函数
            PassStringReturnIndex(str2)
        }
        return line
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        super.setValue(value, forKey: key)
        // 当赋值Comment时计算行高
        if key == "comment" {
            // plist里写的\n都为\\n 这里替换成\n
            comment = (value as!String).stringByReplacingOccurrencesOfString("\\n", withString: "\n")
            // 调用计算行高函数
            line = PassStringReturnIndex(comment)
        }
    }
    // 属性
    var title:String = ""
    var writer:String = ""
    var comment:String = ""
    var line:Int = 0
}
```
####最后再ViewController.swift加入以下代码:
```
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
```
####效果图
![这里写图片描述](http://img.blog.csdn.net/20151206151644876)
####github:https://github.com/Lafree317/Swift-CalculateCellHight
---
本人还是一只小菜鸡,不过是一只热心肠的菜鸡,如果有需要帮助或者代码中有更好的建议的话可以发邮件到lafree317@163.com中,我们一起进步XD
