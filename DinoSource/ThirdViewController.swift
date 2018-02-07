//
//  ThirdViewController.swift
//  DinoSource
//
//  Created by Kenneth on 9/29/16.
//  Copyright © 2016 Kenneth_SSD. All rights reserved.
//

import UIKit
import Foundation

class ThirdViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate,UINavigationControllerDelegate {
    
    let infoText = UITextField()
    let cameraButton = UIButton()
    var selectedPhoto = UIImageView()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Detail View"
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Paper")!)
        
        let boundsx = view.bounds.width
        let boundsy = view.bounds.height
        //create picture save for profile use picture
        //let pictue = UIImage(named: cameraButton)
        let dinoPicture = UIImageView(frame: CGRect(x: 0, y:63, width:boundsx, height:boundsy - boundsy/2))
        dinoPicture.backgroundColor = UIColor(red: 203/255, green: 204/255, blue: 205/255, alpha: 1)
        
        
        view.addSubview(dinoPicture)
        
        let camera = UIButton(frame: CGRect(x:boundsx/2 - 70, y:boundsy/2 - 150, width:140, height:140))
        camera.setImage(#imageLiteral(resourceName: "Camera"), for: .normal)
        camera.layer.cornerRadius = 0.5 * camera.bounds.size.width
        camera.imageEdgeInsets = UIEdgeInsetsMake(18, 25, 25, 25)
        camera.backgroundColor = .white
        camera.addTarget(self, action: #selector(takePhoto), for: .touchDown)
        view.addSubview(camera)
        
        // let infoText = UITextField()
        infoText.frame = CGRect(x: boundsx/2 - 150,y: 390, width:300,height:150)
        infoText.backgroundColor = .clear
        infoText.layer.borderWidth = 1
        infoText.layer.borderColor = UIColor.black.cgColor
    
        infoText.delegate = self
        view.addSubview(infoText)
        
        //make dino name textview
        //make period title text view
        
        let listButton = UIButton(frame: CGRect(x: boundsx / 2 - 120, y: 670, width:110, height: 40 ))
        listButton.backgroundColor = .green
        view.addSubview(listButton)
        
        let homeButton = UIButton(frame: CGRect(x: boundsx / 2 + 20, y: 670, width:110, height: 40 ))
        homeButton.backgroundColor = .green
        view.addSubview(homeButton)
        
        
        let defaults = UserDefaults.standard
        if let fileName = defaults.string(forKey: "newImgName"){
            loadBGImage(fileName: fileName)
        }
        
        
    }
    
    func loadData(forKey chosenKey:String) {
        print("detail says \(chosenKey)")
        //nameText.text = chosenKey
        //use key to look up all dino data form singleton dictionary
        //load dino name
        //load the period title
        //load the image
        //load notes
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true;
        
    }
    
    @objc func takePhoto() {
        view.endEditing(true)
        let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Photo", message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(title: "Take Photo", style: .default) { (alert) -> Void in
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
               
                //UIImageWriteToSavedPhotosAlbum(self.selectedPhoto.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        // 4
        let libraryButton = UIAlertAction(title: "Choose Existing", style: .default) { (alert) -> Void in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        imagePickerActionSheet.addAction(libraryButton)
        // 5
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (alert) -> Void in
        }
        imagePickerActionSheet.addAction(cancelButton)
        // 6
        present(imagePickerActionSheet, animated: true,
                completion: nil)
    }
    
   
    func save(_ sender: AnyObject) {
         UIImageWriteToSavedPhotosAlbum(selectedPhoto.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func openPhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated:  true, completion: nil)
    }
    
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //let boundsx = view.bounds.width
        //let boundsy = view.bounds.height
        
        if let selectedPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            writeToFile(imgData: UIImagePNGRepresentation(selectedPhoto)!)
            
            let defaults = UserDefaults.standard
            let fileName = defaults.string(forKey: "newImgName")
            
            loadBGImage(fileName: fileName!)
        }
        dismiss(animated: true, completion: {
        })
    }
    func writeToFile(imgData: Data){
        
        let fileName = "\(NSDate.timeIntervalSinceReferenceDate).png"
        var filePath = ""
        
        let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        
        if dirs.count > 0 {
            let dir = dirs[0]
            filePath = dir.appendingFormat("/" + fileName)
            print("local path =\(filePath)")
        }else{
                return
        }
        
        do {
            try imgData.write(to: URL.init(fileURLWithPath: filePath),options: .atomic)
        }
        catch let error as NSError{
            print("An error totk place: \(error)")
        }
        let defaults = UserDefaults.standard
            defaults.set(fileName, forKey: "newImgName")
        
        
    }
    func loadBGImage(fileName:String){
       
        let boundsx = view.bounds.width
        let boundsy = view.bounds.height
        
        var filePath = ""
        let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        
        if dirs.count > 0 {
            let dir = dirs[0]
            filePath = dir.appendingFormat("/" + fileName)
            print("local path =\(filePath)")
        }else{
            return
        }
        do{
            let contentFromFile = try Data(contentsOf: URL.init(fileURLWithPath: filePath))
            let dinoPicture = UIImageView(frame: CGRect(x: 0, y:63, width:boundsx, height:boundsy - boundsy/2))
            dinoPicture.image = UIImage(data: contentFromFile)
            
            view.addSubview(dinoPicture)
        }
        catch let error as NSError{
            print("An error took place: \(error)")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

