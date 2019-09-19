//
//  SlipNumberViewController.swift
//  DemoAppMCInfox
//
//  Created by Lachhekumar Nadar on 9/4/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit


extension UITextField{
    
    func addDoneButtonToKeyboard(myAction:Selector?){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: myAction)
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
}

class SlipNumberViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var slipNumberTxt: UITextField!
    @IBOutlet var amountTxt: UITextField!
    @IBOutlet var statusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setIntialSettings()
        // Do any additional setup after loading the view.
    }
    
    
    func setIntialSettings() {
        
        slipNumberTxt.delegate = self
        amountTxt.delegate = self
        amountTxt.keyboardType = .numberPad
        slipNumberTxt.keyboardType = .numberPad
        amountTxt.addDoneButtonToKeyboard(myAction:  #selector(self.amountTxt.resignFirstResponder))
        slipNumberTxt.addDoneButtonToKeyboard(myAction:  #selector(self.slipNumberTxt.resignFirstResponder))

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called\(textField.text!)")
        if(textField == slipNumberTxt ){
         slipNumberTxt.text = textField.text
        }
        else {
            amountTxt.text = textField.text
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("TextField should end editing method called")
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        return true
    }
    
    @IBAction func next(_ sender: Any?) {
        
        
        if(slipNumberTxt.text == "" && amountTxt.text == "") {
            return
        }
        
        if (slipNumberTxt.text != "" && amountTxt.text != "" && slipNumberTxt.text != "0" && amountTxt.text != "0" && slipNumberTxt.text?.count != 0 && amountTxt.text?.count != 0) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let cardVC = storyboard.instantiateViewController(withIdentifier: "CardProcessViewController") as! CardProcessViewController
            cardVC.slipNo = slipNumberTxt.text ?? ""
            cardVC.amount  = amountTxt.text ?? "0.0"
            cardVC.isRefund = true
            self.navigationController?.pushViewController(cardVC, animated: true)
        }
        //self.present(cardVC, animated: true, completion: nil)
    }

}
