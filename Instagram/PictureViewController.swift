//
//  PictureViewController.swift
//  Instagram
//
//  Created by Rohan Gupta on 1/31/18.
//  Copyright © 2018 Rohan Gupta. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var pictureView: UIImageView!
    @IBOutlet var captionTextField: UITextField!
    
    //var originalImage: UIImage!
    
    //var delegate: AppDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func pressCameraRoll(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func pressTakePic(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.camera
        self.present(vc, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        let size = CGSize(width: 288, height: 288)
        let newImage = resize(image: editedImage, newSize: size)
        
        pictureView.image = newImage
        
         dismiss(animated: true, completion: nil)
    }
    @IBAction func enterPressed(_ sender: Any) {
        //Post.postUserImage(image: originalImage, withCaption: captionTextField.text, withCompletion: true)
        let image = pictureView.image
        let caption = captionTextField.text
        
        Post.postUserImage(image: image, withCaption: caption, withCompletion: { (success: Bool, error: Error?) in
            if(success == true) {
                
                self.dismiss(animated: true, completion: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidPost"), object: nil)
                 self.performSegue(withIdentifier: "postUpdateSegue", sender: nil)
                
                
            } else {
                let errorAlertController = UIAlertController(title: "Error!", message: "Some error occured", preferredStyle: .alert)
                let errorAction = UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
                    //dismiss
                })
                errorAlertController.addAction(errorAction)
                self.present(errorAlertController, animated: true)
            }
        })

    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
