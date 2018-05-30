//
//  ViewController.swift
//  calculator
//
//  Created by mayuka on 2018/05/27.
//  Copyright © 2018年 miriaria0427. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    @IBOutlet weak var leftNum: UITextField!
    @IBOutlet weak var rightNum: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    //ピッカーのコンポーネントに含まれるデータを格納
    let dataList = ["+","-","×","÷"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self;
        picker.dataSource = self;
        picker.showsSelectionIndicator = true;
        
        // ピッカーにはじめに表示する項目を指定
        picker.selectRow(1, inComponent: 0, animated: true)
        
        //最初に表示する演算子を＋に設定
        symbolLabel.text = "+"
        
        //キーボードタイプを数字のみに変更
        self.leftNum.keyboardType = UIKeyboardType.numberPad
        self.rightNum.keyboardType = UIKeyboardType.numberPad
        
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        //NSNotificationCenterへ登録
        NotificationCenter.default.addObserver(
              self,
              selector: #selector(textFieldDidChangeL),
              name: NSNotification.Name.UITextFieldTextDidChange,
              object: leftNum)
      
       //NSNotificationCenterへ登録
         NotificationCenter.default.addObserver(
             self,
             selector: #selector(textFieldDidChangeR),
             name: NSNotification.Name.UITextFieldTextDidChange,
             object: rightNum)
        }

    //コンポーネントの個数を返すメソッド
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    //コンポーネントに含まれるデータの個数を返すメソッド
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    //データを返すメソッド
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return dataList[row]
    }
    
    //演算子選択時
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //ラベル表示
        symbolLabel.text = dataList[row]
    }
    
    //計算ボタンが押されたら計算を行う
    @IBAction func calcButton(_ sender: Any) {
        
        let sLabel = symbolLabel.text
        var result :Double = 0
        
        //Double変換(leftNumがnilの場合は空文字とし、Doubleに変換できなかった場合は0扱いとする）
        let lText : String = leftNum.text ?? ""
        let lNum : Double = Double(lText) ?? 0
        let rText : String = rightNum.text ?? ""
        let rNum : Double = Double(rText) ?? 0
        
        //計算をする
        switch sLabel {
        case "+":
            result = lNum + rNum
            print(lNum)
            print(rNum)
            print(result)
        case "-":
            result = lNum - rNum
        case "×":
            result = lNum * rNum
        case "÷":
            result = lNum / rNum
            
        default:
            result = 0
        }
        
        //計算結果を文字列に戻して最後の文字と最後から二番目の文字が.0ならトリムして結果表示
          let num = String(result)
          if(num.suffix(2) == ".0"){
             resultLabel.text = String(num.replacingOccurrences(of:".0", with:""))
         }else{
            resultLabel.text = String(result)
         }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //クリアボタンが押されたら入力値と結果をクリアする
    @IBAction func ClearButton(_ sender: Any) {
        leftNum.text = ""
        rightNum.text = ""
        resultLabel.text = ""
    }

    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }
    
    //入力範囲を9桁までにする(左テキストボックス)
    @objc private func textFieldDidChangeL(notification: NSNotification) {
        let textFieldString = notification.object as! UITextField
        if let text = textFieldString.text {
            if text.count > 9 {
                leftNum.text = String(text.prefix(9))
            }
        }
    }
    
    //入力範囲を9桁までにする(右テキストボックス)
    @objc private func textFieldDidChangeR(notification: NSNotification) {
        let textFieldString = notification.object as! UITextField
        if let text = textFieldString.text {
            if text.count > 9 {
                rightNum.text = String(text.prefix(9))
            }
        }
    }

}

