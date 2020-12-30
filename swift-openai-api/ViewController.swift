//
//  ViewController.swift
//  swift-openai-api
//
//  Created by Jeffrey Berthiaume on 12/22/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var responseText: UITextView!
    @IBOutlet weak var requestText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        requestText.delegate = self
    }

    @IBAction func sendToOpenAI(_ sender: Any) {
        
        let jsonPayload = [
            "prompt": requestText.text ?? "",
            "max_tokens": 200
        ] as [String : Any]
        
        let v = UIView(frame: self.view.bounds)
        v.backgroundColor = .darkGray
        v.alpha = 0.8
        self.view.addSubview(v)
        let spinner = UIActivityIndicatorView(frame: self.view.bounds)
        spinner.color = .lightGray
        self.view.addSubview(spinner)
        spinner.startAnimating()
        
        OpenAIManager.shared.makeRequest(json: jsonPayload) { [weak self] (str) in
            DispatchQueue.main.async {
                self?.responseText.text = str
                
                spinner.stopAnimating()
                spinner.removeFromSuperview()
                v.removeFromSuperview()
            }
        }
        
    }
    
}

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
