//
//  FirstViewController.swift
//  DinoSource
//
//  Created by Kenneth on 10/4/16.
//  Copyright © 2016 Kenneth_SSD. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var selectedPhoto = UIImageView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let boundX = Int(view.bounds.width)
        let boundY = Int(view.bounds.height)
        
        
        //let backGround = UIView()
        
        self.view.backgroundColor = UIColor(red: 234/250, green: 227/250, blue: 224.5/250, alpha: 1)
        
      
        
        let white = UIButton(frame: CGRect(x:view.bounds.width/2 - 70, y:view.bounds.height/2 - 150, width:140, height:140))
        white.layer.cornerRadius = 0.5 * white.bounds.size.width
        white.addTarget(self, action: #selector(takePhoto), for: .touchDown)
        
        white.backgroundColor = .white
        view.addSubview(white)
        
        
        
        let orangeColor = UIColor(red: 235/250, green: 176/250, blue: 89/250, alpha: 1)
        
        
        //change font to one listed in email
        // change font thickness? to 4
        // bold text on buttons?
        
        // ALL CAPITAL LETTERS on all headings
        
        let camera = UIButton(frame: CGRect(x: boundX / 2 - 70, y: boundY  - 160, width: 140, height: 40))
        camera.setTitle("DISCOVER", for: .normal)
        camera.setTitleColor(orangeColor, for: .normal)
        camera.backgroundColor = UIColor.clear
        camera.layer.cornerRadius = 5
        camera.layer.borderWidth = 4
        
        //------Look for an eaisier way or simpler way for entire App
        
        camera.titleLabel?.font = UIFont(name: "Noteworthy", size: 18)
        
        //------
        
        //camera.layer.borderColor = UIColor.whiteColor
        camera.layer.borderColor = orangeColor.cgColor
            camera.addTarget(self, action: #selector(showCamerPage), for: .touchDown)
        view.addSubview(camera)
        
        
        let list = UIButton(frame: CGRect(x: boundX / 2 - 70, y: boundY - 110, width: 140, height: 40))
        list.setTitle("LIST VIEW", for: .normal)
        list.setTitleColor(orangeColor, for: .normal)
        list.titleLabel?.font = UIFont(name: "Noteworthy", size: 18)
        list.backgroundColor = UIColor.clear
        list.layer.cornerRadius = 5
        list.layer.borderWidth = 4
        list.layer.borderColor = orangeColor.cgColor
        list.addTarget(self, action: #selector(showListPage), for: UIControlEvents.touchDown)
        view.addSubview(list)
        
        //--?iforgot what i wanted to do figure it out in the morning
        
        
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
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
         if let selectedPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            writeToFile(imgData: UIImagePNGRepresentation(selectedPhoto)!)
            
            let defaults = UserDefaults.standard
            let fileName = defaults.string(forKey: "newImgName")
            
            loadBGImage(fileName: fileName!)
        }
        dismiss(animated: true, completion: {
        })
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
    
    
    @objc func showCamerPage(){
        
        let camera = SecondViewController()
        navigationController?.pushViewController(camera, animated: true)
        
    }
    
    @objc func showListPage(){
        let list = FourthViewController()
        navigationController?.pushViewController(list, animated: true)
    }
    
    /*func save(_ sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(selectedPhoto.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }*/
    
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
            let dinoPicture = UIImageView(frame: CGRect(x:view.bounds.width/2 - 70, y:view.bounds.height/2 - 150, width:140, height:140))
                dinoPicture.image = UIImage(data: contentFromFile)
                dinoPicture.layer.cornerRadius = 0.5 * dinoPicture.bounds.size.width
            
            view.addSubview(dinoPicture)
        }
        catch let error as NSError{
            print("An error took place: \(error)")
        }
    }
    
}

