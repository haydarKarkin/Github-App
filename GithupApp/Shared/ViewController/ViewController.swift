//
//  ViewController.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import UIKit

class ViewController<T: ViewModelType>: UIViewController {
    
    var viewModel: T!
    var activityView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        bindViewModel()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
    }
    
    func makeUI() {
        updateUI()
    }
    
    func bindViewModel() {
        
        viewModel.onLoadHandling = { [weak self] (isLoading) in
            if isLoading {
                self?.showActivityIndicator()
            } else {
                self?.hideActivityIndicator()
            }
        }
        
        viewModel.onErrorHandling = { [weak self] (error) in
            self?.showAlert()
        }
    }
    
    func updateUI() {}
}

extension ViewController {
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        view.addSubview(activityView!)
        activityView?.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
        view.isUserInteractionEnabled = true
    }
    
    func showAlert( with title: String = Configs.Text.globalErrorTitle,
                    message: String = Configs.Text.globalErrorDesc) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction((UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            alert.dismiss(animated: true, completion: nil)
        })))
        
        self.present(alert, animated: true, completion: nil)
    }
}
