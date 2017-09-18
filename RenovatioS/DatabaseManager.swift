
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
    
    static let shared: DatabaseManager? = DatabaseManager()
    
    private override init() {
        Database.database().isPersistenceEnabled = true
        ref = Database.database().reference()
    }
    
    func save(sutra: SutraObject) {
        ref.child("pics").child(sutra.title).child("title").setValue(sutra.title)
        ref.child("pics").child(sutra.title).child("detailText").setValue(sutra.detailText)
        
        uploadImageToFirebase(image: sutra.image, fileName: sutra.title, completion: { imageURL in
            self.ref.child("pics").child(sutra.title).child("imageURL").setValue(imageURL)
        })
    }
    
    func uploadImageToFirebase(image: UIImage?, fileName: String, completion: @escaping (_ url: String?) -> Void) {
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
    
    func getObjectRef(path: String) -> DatabaseReference {
        return ref.child(path)
    }
    
    func getStorageRef() -> StorageReference {
        return Storage.storage().reference()
    }
    
    func getImageURLFor(path: String, success: @escaping (URL) -> Void) {
        let imageRef = Storage.storage().reference().child(path)
        imageRef.downloadURL { (url, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                success(url!)
            }
        }
    }
    
    
}
