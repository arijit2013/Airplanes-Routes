//
//  ViewController.swift
//  Airplanes Routes
//
//  Created by Arijit Das on 19/02/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var txtOrigin: UITextField!
    @IBOutlet var txtDestination: UITextField!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var btnDisplay: UIButton!
    @IBOutlet var lblDetails: UILabel!
    
    var count = 0
    var First = ""
    var Last = ""
    var isFirstUnique = false
    var isLastUnique = false
    var activeTextField: UITextField!
    var toolBar: UIToolbar!
    var codePicker: UIPickerView!
    
    var inputArr = ["JFK", "SFO", "BOS", "MIA", "PEK"]
    var elementArr: [String] = []
    var outputArr: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnSaveAction(_ sender: UIButton) {
        if ((txtOrigin.text?.count ?? 0 > 0) && (txtDestination.text?.count ?? 0 > 0)) {
            let entry = txtOrigin.text!
            elementArr.append(entry)
            
            let end = txtDestination.text!
            elementArr.append(end)
            self.alertWithText(alertTxt: "Origin & Destination saved successfully.", title: "Success", alertBtnTitle: "OK", parentVC: self)
            txtOrigin.text = ""
            txtDestination.text = ""
        } else {
            self.alertWithText(alertTxt: "Please input both Origin & Destination Airport.", title: "Error", alertBtnTitle: "OK", parentVC: self)
        }
    }
    
    @IBAction func btnDisplayAction(_ sender: UIButton) {
        var fullText = ""
        var element = ""
        var final = ""
        
        for item in elementArr {
            let index = elementArr.firstIndex(where: {$0 == item}) ?? 0
            if (First.count == 0) {
                First = item
            }
            if (index == (elementArr.count - 1)) {
                Last = item
            }
            
            if (elementArr.contains(First)) {
                isFirstUnique = false
            } else {
                isFirstUnique = true
            }
            
            let firstCount = elementArr.filter{$0 == First}.count
            
            if (firstCount > 1) {
                isFirstUnique = false
            } else {
                isFirstUnique = true
            }
            
            let lastCount = elementArr.filter{$0 == Last}.count
            
            if (lastCount > 1) {
                isLastUnique = false
            } else {
                isLastUnique = true
            }
            
            if (index % 2 == 0) {
                element = String(format: "(\"%@\",", item)
            } else if (index == 0) {
                element = String(format: "(\"%@\",", item)
            } else if (index % 2 != 0) {
                element = String(format: " \"%@\")", item)
            }
            
            if (fullText.count == 0) {
                fullText = element
            } else {
                fullText = fullText + element
                self.outputArr.append(fullText)
                fullText = ""
            }
        }
        
        for output in outputArr {
            if (final.count == 0) {
                final = output
            } else {
                final = final + "," + output
            }
        }
        
        outputArr = []
        
        self.lblDetails.text = "[\(final)]"
        
        if !(isFirstUnique && isLastUnique) {
            self.alertWithText(alertTxt: "Output is not in correct format, origin & destination should be unique.", title: "Error", alertBtnTitle: "OK", parentVC: self)
        }
    }
    
    func createToolbar(_ textField: UITextField){
        if (toolBar != nil) {
            toolBar.removeFromSuperview()
        }
        toolBar = UIToolbar()
        toolBar.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 50)
        toolBar.barStyle = .black
        toolBar.isTranslucent = true
        toolBar.backgroundColor = UIColor.gray
        toolBar.tintColor = UIColor.white
        //toolBar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        toolBar.setItems([spaceButton, doneButton], animated: false)
        textField.inputAccessoryView = toolBar
    }
    
    func createPicker(textField: UITextField) {
        createToolbar(textField)
        if (codePicker != nil) {
            codePicker.removeFromSuperview()
        }
        codePicker = UIPickerView()
        codePicker.dataSource = self
        codePicker.delegate = self
        textField.inputView = codePicker
    }
    
    @objc func doneClick() {
        if (toolBar != nil) {
            toolBar.removeFromSuperview()
        }
        if (codePicker != nil) {
            codePicker.removeFromSuperview()
        }
        activeTextField.resignFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextField = textField
        createPicker(textField: textField)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(textField.text ?? "")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func alertWithText(alertTxt: String, title: String, alertBtnTitle: String, parentVC: UIViewController) {
        let alert = UIAlertController(title: title, message: alertTxt, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: alertBtnTitle, style: UIAlertAction.Style.default, handler: nil))
        parentVC.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return inputArr.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return inputArr[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeTextField.text = inputArr[row]
    }
}
