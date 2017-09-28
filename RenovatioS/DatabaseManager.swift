
//
//  DatabaseManager.swift
//  RenovatioS
//
//  Created by Dan Leonard on 9/9/17.
//  Copyright © 2017 TPOYP. All rights reserved.
//

import FirebaseDatabase
import FirebaseStorage
import UIKit

class DatabaseManager: NSObject {
    var ref: DatabaseReference!
    static let shared: DatabaseManager! = DatabaseManager()
    fileprivate var allObjects: [String: SutraObject] = [:]
    
    private override init() {
        Database.database().isPersistenceEnabled = true
        ref = Database.database().reference()
    }
    
    func save(sutra: SutraObject) {
        ref.child("pics").child(sutra.title).child("title").setValue(sutra.title)
        ref.child("pics").child(sutra.title).child("detailText").setValue(sutra.detailText)
        ref.child("pics").child(sutra.title).child("index").setValue(sutra.index)
        uploadImageToFirebase(image: sutra.image, fileName: sutra.title, completion: { imageURL in
            self.ref.child("pics").child(sutra.title).child("imageURL").setValue(imageURL)
        })
    }
    
    fileprivate func uploadImageToFirebase(image: UIImage?, fileName: String, completion: @escaping (_ url: String?) -> Void) {
        guard let image = image, let imageData = UIImagePNGRepresentation(image) else { return }
        
        let storageRef = Storage.storage().reference().child("pics").child(fileName)
        let meta = StorageMetadata()
        meta.contentType = "image/png"
        storageRef.putData(imageData, metadata: meta) { (meta, error) in
            if error != nil {
                print("Error: \(error!.localizedDescription)")
            } else {
                completion(meta!.path)
            }
        }
    }
    
    func getAllObject() -> [SutraObject] {
        return allObjects.flatMap{ $0.value }
    }
    
    fileprivate func getObjectRef(path: String) -> DatabaseReference {
        return ref.child(path)
    }
    
    func fetchObjects() {
        let sutraRef = getObjectRef(path: "pics")
        sutraRef.observe(.childAdded, with: { (snapshot) -> Void in
            self.allObjects[SutraObject(snapshot: snapshot)!.title] = self.getImageFor(object: SutraObject(snapshot: snapshot)!)
            //self.allObjects.append(self.getImageFor(object: SutraObject(snapshot: snapshot)!))
            NotificationCenter.default.post(name: Notification.Name("newImages"), object: self)
        })
        sutraRef.observe(.childChanged, with: { (snap) -> Void in
            self.allObjects[SutraObject(snapshot: snap)!.title] = self.getImageFor(object: SutraObject(snapshot: snap)!)
            NotificationCenter.default.post(name: Notification.Name("newData"), object: nil)
        })
    }
    
//    func obseverChanges() {
//        let sutraRef = getObjectRef(path: "pics")
//        sutraRef.observe(.childChanged, with: { (snap) -> Void in
//            self.allObjects[SutraObject(snapshot: snap)!.title] = self.getImageFor(object: SutraObject(snapshot: snap)!)
//            NotificationCenter.default.post(name: Notification.Name("newData"), object: nil)
//        })
//    }
    
    fileprivate func getImageFor(object: SutraObject)-> SutraObject {
        var newObject = object
        if let image = self.getImageFromLocalFile(fileURL: "\(object.title).png") {
            newObject.image = image
        } else {
            self.downloadImageLocaly(imageName: object.title, completion: { (image) in
                newObject.image = image
                self.allObjects[object.title] = object
            })
        }
        return newObject
    }
    
    fileprivate func getStorageRef() -> StorageReference {
        return Storage.storage().reference()
    }
    
    fileprivate func getImageURLFor(path: String, success: @escaping (URL) -> Void) {
        let imageRef = Storage.storage().reference().child(path)
        imageRef.downloadURL { (url, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                success(url!)
            }
        }
    }
    
    fileprivate func downloadImageLocaly(imageName: String, completion: @escaping (UIImage?) -> Void) {
        let storageRef = getStorageRef()
        let imageRef = storageRef.child("pics").child(imageName)
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsURL.appendingPathComponent("\(imageName).png")
        imageRef.write(toFile: fileURL) { (url, error) in
            if let error = error {
                print("Download Image locally error: ", error.localizedDescription)
            } else {
                let image = self.getImageFromLocalFile(fileURL: "\(imageName).png")
                completion(image)
            }
        }
    }
    
    fileprivate func getImageFromLocalFile(fileURL: String?) -> UIImage? {
        guard let fileURL = fileURL else { return nil }
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsURL.appendingPathComponent(fileURL).path
        if FileManager.default.fileExists(atPath: filePath) {
            return UIImage(contentsOfFile: filePath)
        }
        return nil
    }
}
