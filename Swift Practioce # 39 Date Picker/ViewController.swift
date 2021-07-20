//
//  ViewController.swift
//  Swift Practioce # 39 Date Picker
//
//  Created by CHEN PEIHAO on 2021/7/20.
//

import UIKit

class ViewController: UIViewController {
    
    //照片IMageView
    @IBOutlet weak var tenYearImageView: UIImageView!
    //date picker 的 outlet
    @IBOutlet weak var dayChangedDatePicker: UIDatePicker!
    //slider的 outlet
    @IBOutlet weak var yearsChangeSlider: UISlider!
    //改變日期label的 outlet
    @IBOutlet weak var yearsChangeLabel: UILabel!
    //switch的outlet
    @IBOutlet weak var timerSwitch: UISwitch!
    
    //定義image變數供後續使用
    var imageNumber = 0
    //定義slider變數供後續使用
    var sliderNumber = 0
    //定義一個使用時間DateFormatter()的常數
    let dateformatter = DateFormatter()
    //定義一個array內置照片的名稱
    let imageName = ["2012.jpg","2013.jpg","2014.jpg","2015.jpg","2016.jpg","2017.jpg","2018.jpg","2019.jpg","2020.jpg","2021.jpg"]
    //定義一個array內置照片年份的string
    let yearsLabel = [2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //透過dateformatter.dateFormat取得時間格式
        dateformatter.dateFormat = "yyyy/MM/dd"
    }
    //定義變數與函式給後面的timer switch與IBAction使用
    //定義一個變數空字串給dateString使用
    var dateString : String = ""
    //定義一個function並內置一個case作為判斷日期的參數使用
    func pictureDateSelect(number: Int){
        switch number {
        case 0:
            dateString = "2012/01/01"
        case 1:
            dateString = "2013/02/01"
        case 2:
            dateString = "2014/03/01"
        case 3:
            dateString = "2015/04/01"
        case 4:
            dateString = "2016/05/01"
        case 5:
            dateString = "2017/06/01"
        case 6:
            dateString = "2018/07/01"
        case 7:
            dateString = "2019/08/01"
        case 8:
            dateString = "2020/09/01"
        default:
            dateString = "2021/10/01"
        }
        //定義一個日期天數，數值從function取得後指派
        let date = dateformatter.date(from: dateString)
        //讓date picker的時間透過上面一行程式取得取得後給後面使用
        dayChangedDatePicker.date = date!
        //先取得dayChangedDatePicker.date後指派給dateComponets，用於下一行使用
        let dateComponets = Calendar.current.dateComponents(in: TimeZone.current, from: dayChangedDatePicker.date)
        //讓剛剛定義好的dateComponets當中取得特定的年份日期後指派給year
        let year = dateComponets.year!
        //可以變動的年份標籤顯示內容則為上面取得的year
        yearsChangeLabel.text = "\(year)"
    }
    
    //定義timer為timer的時間格式
    var timer : Timer?
    //建立一個fuction的程序為自動輪播的功能
    func autoTime (){
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: {(timer) in self.compare() })
    }
    
    
    func compare () {
        //若是imageNumber的變數超過了imageName.count的array可以數的數
        //那麼imageNumber被判斷為0
        if imageNumber >= imageName.count {
            imageNumber = 0
            //自建的pictureDateSelect函式的數字follow自定義imageNumber的值
            pictureDateSelect(number: imageNumber)
            //imageview照片的顯示的圖片名字則為imageName
            tenYearImageView.image = UIImage(named: String(imageName[imageNumber]))
            
        }else{
            //若是imageNumber的值在imageName.count範圍內
            pictureDateSelect(number: imageNumber)
            //顯示的照片的值透過UIImage(named: String(imageName[imageNumber]))來判定
            tenYearImageView.image = UIImage(named: String(imageName[imageNumber]))
        }
        //slider的值透過透過Float(imageNumber)來取得
        yearsChangeSlider.value = Float(imageNumber)
        imageNumber += 1
    }
    
    
    //Date Picker 的 IBAction
    @IBAction func dateSelect(_ sender: UIDatePicker) {
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: dayChangedDatePicker.date)
        let year = dateComponents.year!
        let pictureSelect = "\(year).jpg"
        tenYearImageView.image = UIImage(named: pictureSelect)
        yearsChangeSlider.value = Float(year - 2012)
        yearsChangeLabel.text = "\(year)"
    }
    
    
    //slider的action
    @IBAction func yearChange(_ sender: UISlider) {
        sender.value = round(sender.value)
        let newDate = DateComponents(calendar: Calendar.current, year: yearsLabel[sliderNumber]).date
        dayChangedDatePicker.date = newDate!
        sender.value.round()
        sliderNumber = Int(yearsChangeSlider.value)
        yearsChangeLabel.text = String(yearsLabel[sliderNumber])
        tenYearImageView.image = UIImage(named: String(imageName[sliderNumber]))
    }
    
    
    //switch的action
    @IBAction func autoPhotoSwitch(_ sender: UISwitch) {
        //判斷Switch的開關若開啟
        if sender.isOn{
            autoTime()
            imageNumber = sliderNumber
            yearsChangeSlider.value = Float(imageNumber)
            
        }else{
            //若是關閉switch，使用timer.invalidate的功能關閉自動輪播
            timer?.invalidate()
        }
    }
    
    
}

