//
//  WHOpthionButton.swift
//  WHCalendar
//
//  Created by 王浩 on 2018/8/28.
//  Copyright © 2018年 haoge. All rights reserved.
//

import UIKit

let KRowHeight: CGFloat = 44.0
let KOptionButtonCell = "KOptionButtonCell"
let KMaxShowLine:Int = 7
class WHOpthionButton: UIView {
    var callBack: ObjectCallback?
    var row: Int?
    fileprivate var model: CalendarModel!
    fileprivate var button: UIButton!
    fileprivate var cover: UIControl!
    fileprivate var tableView: UITableView!
    fileprivate var optionArray: [String]? {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    var title: String? {
        didSet{
            button.setTitle(title ?? "", for: .normal)
            let size = calculateTextSize(text: title ?? "", font: (button.titleLabel?.font)!)
            let imageLeftWidth = size.width
            let titleLeftWidth = button.imageView?.bounds.width
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: imageLeftWidth, bottom: 0, right: -imageLeftWidth)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -titleLeftWidth!, bottom: 0, right: titleLeftWidth!)
        }
    }
    
    init(frame: CGRect, row: Int, array: [String]?, model: CalendarModel) {
        super.init(frame: frame)
        self.model = model
        self.row = row
        self.optionArray = array
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        button = UIButton(type: .custom)
        button.setTitleColor(model.optionButtonTextColor, for: .normal)
        button.titleLabel?.font = model.optionButtonFont
        button.setImage(UIImage(named:"bottom"), for: .normal)
        button.setImage(UIImage(named:"up"), for: .selected)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        self.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self)
        }
        //选项视图
        tableView = UITableView()
        tableView.rowHeight = KRowHeight
        tableView.separatorStyle = .none
        tableView.layer.borderWidth = 1.0
        tableView.layer.borderColor = UIColor(hexString: "#efeff4").cgColor
        tableView.delegate = self
        tableView.dataSource = self
    }
 
    @objc fileprivate func buttonAction(_ sender: UIButton) {
        if sender.isSelected { return }
        sender.isSelected = true
        self.creatControl()
    }
    
    fileprivate func creatControl() {
        //遮盖视图
        cover = UIControl()
        cover.frame = UIScreen.main.bounds
        cover.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
        cover.addTarget(self, action: #selector(tapAction(_:)), for: .touchUpInside)
        //布局子控件
        let vc = UIApplication.shared.keyWindow
        vc?.addSubview(cover)
        //将约束更新为坐标
        self.layoutIfNeeded()
        //坐标转换
        let frame = self.superview?.convert(self.frame, to: self.cover)
        //设置frame
        let rowCount = KMaxShowLine
        let tabelViewY =  frame?.maxY
        if (optionArray?.count)! <= rowCount {
            tableView.frame = CGRect(x: (frame?.origin.x)!, y: tabelViewY!, width: (frame?.size.width)!, height: CGFloat((optionArray?.count)!)*KRowHeight)
        } else {
            tableView.frame = CGRect(x: (frame?.origin.x)!, y: tabelViewY!, width: (frame?.size.width)!, height: CGFloat(rowCount)*KRowHeight)
        }
        
        //初始tableView位置
        let ip = IndexPath(row: row!, section: 0)
        tableView.selectRow(at: ip, animated: false, scrollPosition: .none)
        tableView.scrollToRow(at: ip, at: .top, animated: false)
        cover.addSubview(self.tableView)
    }

    fileprivate func removeCover() {
        button.isSelected = false
        cover.removeFromSuperview()
    }
    
    @objc fileprivate func tapAction(_ gesture: UITapGestureRecognizer) {
        removeCover()
    }
    
    fileprivate func dismissOption() {
        self.removeCover()
    }
    
    //MARK:-计算字体大小
    func calculateTextSize(text: String, font: UIFont) -> CGSize {
        let str = NSString(string: text)
        let size = str.size(withAttributes: [NSAttributedStringKey.font: font])
        return size
    }
}

extension WHOpthionButton: UITableViewDelegate, UITableViewDataSource {
    //mark - tableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: KOptionButtonCell)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: KOptionButtonCell)
        }
        cell?.textLabel?.textAlignment = .center
        cell?.textLabel?.text = optionArray?[indexPath.row]
        cell?.backgroundColor = UIColor.white
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row = indexPath.row
        self.title = optionArray?[row!]
        self.dismissOption()
        //此处回调方法
        callBack?(self)
    }
}

//MARK:-格式日期
func dateFromFormat(date: String?) -> Date {
    var date = date
    func formatString(date: String) -> String {
        var characters = [Character]()
        for c in date {
            characters.append(c)
        }
        characters.insert("-", at: 4)
        characters.insert("-", at: 7)
        let str = String(characters)
        return str
    }
    
    if date != nil && date != "" {
        if !(date?.contains("-"))! {
            date = formatString(date: date!)
        }
    }
    
    let dateFormat = DateFormatter()
    dateFormat.locale = Locale.current
    dateFormat.dateFormat = "yyyy-MM-dd"
    let d = dateFormat.date(from: date ?? "")
    return d ?? Date()
}


