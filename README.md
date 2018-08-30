# WHCalendar
纯Swift实现日历Demo
项目使用SnapKit进行约束布局
使用步骤:
let calendar = WHCalendar()
        calendar.dafaultDate = self.defaultDate
        calendar.animationType = .center
        //自定义显示界面
//        calendar.model = CalendarModel()
        calendar.callback = { [unowned self](value) in
            if let date = value as? String {
                self.defaultDate = dateFromFormat(date: date)
                self.dateButton.setTitle("设置日期: \(date)", for: .normal)
            }
        }
        calendar.show()
     
     
 注:
 1. calendar.animationType = .center  可以指定日历弹出样式  center  bottom  top
 2. calendar.model = CalendarModel() 可以自定义界面文字大小颜色
 /**左侧视图背景色*/
var leftViewBackgroundColor: UIColor = KMainColor
/**右侧视图背景色*/
var rightViewBackgroundColor: UIColor = UIColor(hexString: "#efeff4")
/**星期视图背景色*/
var weekBackgroundColor: UIColor = .orange
/**星期字体颜色*/
var weekLabelTextColor: UIColor = .white
/**星期字体大小*/
var weekLabelFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 15 : 20)
/**左侧年字体颜色*/
var yearLabelTextColor: UIColor = KbackColor
/**左侧年字体大小*/
var yearLabelFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 17 : 24)
/**左侧月字体颜色*/
var monthLabelTextColor: UIColor = .white
/**左侧月字体大小*/
var monthLabelFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 17 : 24)
/**左侧天字体颜色*/
var dayLabelTextColor: UIColor = .white
/**左侧天字体大小*/
var dayLabelFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 35 : 44)
/**选择按钮字体颜色*/
var optionButtonTextColor: UIColor = .black
/**选择按钮字体大小*/
var optionButtonFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 13 : 16)
/**今天字体大小*/
var todayButtonFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 13 : 16)
/**今天字体颜色*/
var todayButtonTextColor: UIColor = .black
/**星期标签的字体大小*/
var rightWeekLabelFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 13 : 16)
/**星期标签的字体颜色*/
var rightWeekLabelTextColor: UIColor = .black
/**天按钮默认字体大小*/
var dayButtonDefaultFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 13 : 16)
/**天按钮默认字体颜色*/
var dayButtonDefaultTextColor: UIColor = .black
/**天按钮默认背景颜色*/
var dayButtonDefaultBackgroundColor: UIColor = .white
/**天按钮选中字体大小*/
var dayButtonSelectorFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 13 : 16)
/**天按钮选中字体颜色*/
var dayButtonSelectorTextColor: UIColor = KMainColor
/**天按钮选中背景颜色*/
var dayButtonSelectorBackgroundColor: UIColor = KbackColor
/**取消字体颜色*/
var cancelButtonTextColor: UIColor = KMainColor
/**取消字体大小*/
var cancelButtonFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 13 : 16)
/**确定字体颜色*/
var sureButtonTextColor: UIColor = KMainColor
/**确定字体大小*/
var sureButtonFont: UIFont = UIFont.systemFont(ofSize: DeviceInfo.IS_4_INCHES() ? 13 : 16)
