//
//  SecondViewController.swift
//  DinoSource
//
//  Created by Kenneth on 9/29/16.
//  Copyright © 2016 Kenneth_SSD. All rights reserved.
//

import UIKit
import Foundation

class SecondViewController: UIViewController, UINavigationControllerDelegate /*UIImagePickerControllerDelegate*/ {
    
    var textView: UITextView?
    var activityIndicator:UIActivityIndicatorView?
    //second page with tesseract page within text recoginize then to detaialed view in forth view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Discover"
        
        let bounds = UIScreen.main.bounds
        
        textView = UITextView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        textView?.backgroundColor = UIColor(red: 69/255, green: 70/255, blue: 71/255, alpha: 1)
        textView?.isEditable = false
        
        view.addSubview(textView!)
        
        let takePhotoBut = UIButton(frame:CGRect(x: bounds.width/2 - 50, y:bounds.height/2 - 38.5 , width: 100, height: 78))
        //takePhotoBut.setTitle("Take Photo", for: UIControlState())
        takePhotoBut.backgroundColor = UIColor.clear
        takePhotoBut.setImage(#imageLiteral(resourceName: "Camera"), for: .normal)
        takePhotoBut.setTitleColor(UIColor.blue, for: UIControlState())
        takePhotoBut.addTarget(self, action: #selector(takePhoto), for: .touchDown)
        view.addSubview(takePhotoBut)
        // textSearch("zigongosaurus")
        
        takePhoto()
        print(PlistManager.sharedInstance.getKeys().sorted())
        
    }
    
    @objc func takePhoto(/*_ sender: AnyObject*/) {
        // 1
        view.endEditing(true)
        // 2
        let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Photo",
                                                       message: nil, preferredStyle: .actionSheet)
        // 3
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(title: "Take Photo",
                                             style: .default) { (alert) -> Void in
                                                let imagePicker = UIImagePickerController()
                                                imagePicker.delegate = self
                                                imagePicker.sourceType = .camera
                                                self.present(imagePicker,
                                                             animated: true,
                                                             completion: nil)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        // 4
        let libraryButton = UIAlertAction(title: "Choose Existing",
                                          style: .default) { (alert) -> Void in
                                            let imagePicker = UIImagePickerController()
                                            imagePicker.delegate = self
                                            imagePicker.sourceType = .photoLibrary
                                            self.present(imagePicker,
                                                         animated: true,
                                                         completion: nil)
        }
        imagePickerActionSheet.addAction(libraryButton)
        // 5
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel) { (alert) -> Void in
        }
        imagePickerActionSheet.addAction(cancelButton)
        // 6
        present(imagePickerActionSheet, animated: true,
                completion: nil)
    }
    
    /*func imagePickerController(_ picker: UIImagePickerController,
     didFinishPickingMediaWithInfo info: [String : Any]) {
     let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
     let scaledImage = scaleImage(selectedPhoto, maxDimension: 640)
     
     addActivityIndicator()
     
     dismiss(animated: true, completion: {
     self.performImageRecognition(scaledImage)
     })
     }*/
    
    func scaleImage(_ image: UIImage, maxDimension: CGFloat) -> UIImage {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        var scaleFactor:CGFloat
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = image.size.width / image.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        image.draw(in: CGRect(x: 0, y: 0, width: scaledSize.width, height: scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    // Activity Indicator methods
    
    func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator?.activityIndicatorViewStyle = .whiteLarge
        activityIndicator?.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator?.startAnimating()
        view.addSubview(activityIndicator!)
    }
    
    func removeActivityIndicator() {
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
    }
    
    func performImageRecognition(_ image: UIImage) {
        //https://groups.google.com/forum/#!msg/tesseract-ocr/AyCNiju1x1Y/ANyiQ9sR5UIJ
        // 1
        let tesseract = G8Tesseract()
        // 2
        tesseract.language = "eng"
        // 3
        tesseract.engineMode = .tesseractCubeCombined
        // 4
        tesseract.pageSegmentationMode = .auto
        // 5
        tesseract.maximumRecognitionTime = 60.0
        // 6
        tesseract.image = image.g8_blackAndWhite()
        
        tesseract.charWhitelist = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        tesseract.charBlacklist = "0123456789.,:;'~!@#$%^&*()[]{}<>"
        
        
        tesseract.recognize()
        // 7
        textView?.text = tesseract.recognizedText
        textView?.isEditable = true
        // 8
        removeActivityIndicator()
        
        
        textSearch(tesseract.recognizedText)
        
        print(tesseract)
    }
    
    ///in the func text search you should be able to refernce the dino dictinary the be able to compare it ti the text view in whicth at theat time it compares to the textview and if any matching are correct it would then print out yess this ids the dino you found until we link it to the next step..-------
    ////-----in sense  i think i am heading on the correct path but im not to sure if so  what do you think???
    func textSearch(_ tesseractText:String) {
        let text = tesseractText
        //split tesseractText into individual words
        let split = text.split(separator: " ").map(String.init)
        
        let foundAlert = UIAlertController(title:"Found", message: nil, preferredStyle: .actionSheet)
        
        var foundDino = false
        
        for words in split {
            if let found = PlistManager.sharedInstance.getValueForKey(words.lowercased()) {
                print("Dino found")
                foundDino = true
                print("Dino found")
                
                let foundDict = found as! NSDictionary
                print("Dino found")
               
                
                // create a bool to change cavle to caught
                //----->
                
                let caughtVal:Bool = (foundDict.value(forKey: "caught") as! Bool)
                if(!caughtVal) {  //if found and not caught
                   
                    print("Dino found")
                    PlistManager.sharedInstance.removeItemForKey(foundDict.value(forKey: "name") as! String)
                    PlistManager.sharedInstance.updateCaughtKeysWith(newDino: words.lowercased())
                    
                    let dinoName = foundDict.value(forKey: "name") as! String
                    let dinoPeriod = foundDict.value(forKey: "period") as! String
                    ///----->
                    let dict = ["name": dinoName, "period": dinoPeriod, "caught": 1] as [String : Any]
                    
                    
                    PlistManager.sharedInstance.addNewItemWithKey(dinoName, value: dict as AnyObject)
                    //alert you caught dinosaur words.lowercased()
                    //send them the detail view for this dino
                    if (foundDino == true){
                        let okButton = UIAlertAction(title:"Found \(dinoName.lowercased()) ", style: .default){ (alert) -> Void in
                            
                            let ok = FourthViewController()
                            self.navigationController?.pushViewController(ok, animated: true)
                            
                            
                        }
                        foundAlert.addAction(okButton)
                        self.present(foundAlert,animated: true,completion: nil)
                    }
                } else { //if found and already caught
                    foundDino = true
                    let foundButton = UIAlertAction(title:"Already Found!", style: .default){ (alert) -> Void in
                        let ok = FourthViewController()
                        self.navigationController?.pushViewController(ok, animated: true)
                    }//end closure
                    foundAlert.addAction(foundButton)
                    self.present(foundAlert,animated: true,completion: nil)
                } //end else
                //alert the dinousaur words.lowercased() has already been found
                break
            }//end for loop
        }// end for loop
        if (foundDino == false){
            let retryButton = UIAlertAction(title:"ReTake", style: .default){ (alert) -> Void in
                //alert dino for retake
                self.takePhoto()
            }//end closure
            foundAlert.addAction(retryButton)
            self.present(foundAlert,animated: true,completion: nil)
        } //end found false if
    }//end function
    
    
    
    //After that, make a separate, brand new program to read in dinos.txt and turn it into a dictionary.
    //you accidentally had this function inside the textSearch function, so no other method could call it. You need to move it outside like I did.
    func dinosFromResource(_ fileName: String) -> [String]? {
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: nil) else {
            return nil
        }
        do {
            let content = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            return content.components(separatedBy: "\n")
        } catch {
            return nil
        }
    }
}

extension SecondViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        let scaledImage = scaleImage(selectedPhoto, maxDimension: 640)
        
        addActivityIndicator()
        
        dismiss(animated: true, completion: {
            self.performImageRecognition(scaledImage)
        })
    }
}
