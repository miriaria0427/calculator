//
//  ViewController.swift
//  calculator
//
//  Created by mayuka on 2018/05/27.
//  Copyright © 2018年 miriaria0427. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
    
    
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
        leftNum.delegate = self
        rightNum.delegate = self
        leftNum.tag = 7
        rightNum.tag = 7
        
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
    }
    
    //文字列制限 //なんか8桁までしか入力できないから明日直す
    //func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //self.pass(st:leftNum.text!, tag: leftNum.tag, textField: leftNum)
        //self.pass(st:rightNum.text!, tag: rightNum.tag, textField: rightNum)
        //return true
    //}
    
    //func pass(st:String,tag:Int,textField:UITextField) {
        //if st.count > tag {
            //textField.text = String((st.prefix(tag)))
        //}
    //}
    
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
        //確認用
        //print("列: \(row)")
        //print("値: \(dataList[row])")
        //ラベル表示
        symbolLabel.text = dataList[row]
    }
    
    //計算ボタンが押されたら計算を行う
    @IBAction func calcButton(_ sender: Any) {
        
        let sLabel = symbolLabel.text
        var result :Float = 0

        //Float変換(leftNumがnilの場合は空文字とし、Floatに変換できなかった場合は0扱いとする）
        let lText : String = leftNum.text ?? ""
        let lNum : Float = Float(lText) ?? 0
        let rText : String = rightNum.text ?? ""
        let rNum : Float = Float(rText) ?? 0
        
        //計算をする
        switch sLabel {
        case "+":
            result = lNum + rNum
        case "-":
            result = lNum - rNum
        case "×":
            result = lNum * rNum
        case "÷":
            result = lNum / rNum
            
        default:
            result = 0
        }
        
        //計算結果を文字列に戻す。最後の文字と最後から二番目の文字が.ならトリム
        var num = String(result)
        print(num.count)
        print("末尾から2文字:\(num.suffix(2))")
        if(num.suffix(2) == ".0"){
           num = num.replacingOccurrences(of:".0", with:"")
            resultLabel.text = String(num)
        }else{
        //計算結果を表示させる。
        resultLabel.text = String(result)
        }
    }
    
    //クリアボタンが押されたら入力値と結果をクリアする
    @IBAction func ClearButton(_ sender: Any) {
        leftNum.text = ""
        rightNum.text = ""
        resultLabel.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }

}

