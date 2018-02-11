//
//  StoreViewController.swift
//  Memorization Exercise Game
//
//  Created by Kien Phan on 1/10/18.
//  Copyright © 2018 Kien Phan. All rights reserved.
//

import UIKit
import StoreKit

class StoreViewController: UIViewController, SKPaymentTransactionObserver, SKProductsRequestDelegate {

    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var returnToGameButton: UIButton!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDiscription: UITextView!
    @IBOutlet weak var restoreButton: UIButton!
    
    var product: SKProduct?
    var productID = "KienPhan.Memorization_Exercise_Game.removeads"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buyButton.isEnabled = false
        SKPaymentQueue.default().add(self)
        getPurchaseInfo()
    }

    override func viewDidAppear(_ animated: Bool) {
        let save  = UserDefaults.standard // for removeads purchase
        if save.value(forKey: "purchased") != nil { // If there is nothing in purchased key in memory then the
            buyButton.isEnabled = false // User wont be able to see this becuase the segueButton is removedr but just in case
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: This button will return to game View
    @IBAction func ReturnToGameButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: This button will allow users to purchase our remove ads product
    @IBAction func purchaseButtonTapped(_ sender: Any) {
        let payment = SKPayment(product: product!)
        SKPaymentQueue.default().add(payment)
    }
    
    @IBAction func restoreButtonTapped(_ sender: Any) {
        
        SKPaymentQueue.default().restoreCompletedTransactions() //check the user's account for all the purchases he made on this app and go through all the function to make everything he purchased availible to him
        
    }
    
    
    func getPurchaseInfo() {
        
        if SKPaymentQueue.canMakePayments() {
            
            let request = SKProductsRequest(productIdentifiers: NSSet(objects: self.productID) as! Set<String>)
            
            request.delegate = self
            request.start()
            
        } else {
            
            productTitle.text = "Warning"
            productDiscription.text = "Please enable in app purchases in your setting"
            
        }
        
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        let products = response.products
        
        if products.count == 0 {
            print("\(products.count)")
            productTitle.text = "Warning"
            productDiscription.text = "Product Not Found!"
        } else {
            product = products[0]
            productTitle.text = product!.localizedTitle
            productDiscription.text = product!.localizedDescription
            buyButton.isEnabled = true
        }
        
        let invalids = response.invalidProductIdentifiers
        
        for product in invalids {
            print("product not found: \(product)")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            switch transaction.transactionState {
                
            case SKPaymentTransactionState.purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                productTitle.text = "Thank You!"
                productDiscription.text = "The product has been purchased"
                buyButton.isEnabled = false
                
                let save = UserDefaults.standard //create a save point so that if the user purchased it it will be true which means that we should remove the ads
                save.set(true, forKey: "purchased")
                save.synchronize()
                
            case SKPaymentTransactionState.restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                productTitle.text = "Thank You!"
                productDiscription.text = "The product has been purchased"
                buyButton.isEnabled = false
                
                let save = UserDefaults.standard //create a save point so that if the user purchased it it will be true which means that we should remove the ads
                save.set(true, forKey: "purchased")
                save.synchronize()
                
            case SKPaymentTransactionState.failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                productTitle.text = "Warning"
                productDiscription.text = "The product has not been purchased"
                
            default:
                break
            }
        }
        
    }
    
}
