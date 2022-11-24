//
//  WeatherSettingsViewController.swift
//  News App
//
//  Created by Mikołaj Dawczyk on 23/11/2022.
//

import UIKit

class WeatherSettingsViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        searchTextField.delegate = self
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

//MARK: - UITextFieldDelegate

extension WeatherSettingsViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let phrase = textField.text {
            
        }
        textField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            return false
        }
    }
}
