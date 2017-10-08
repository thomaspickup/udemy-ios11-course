//
//  vcMain.swift
//  Pixel City
//
//  Created by Thomas Pickup on 09/09/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import AlamofireImage

class vcMap: UIViewController, UIGestureRecognizerDelegate{
    // Outlets
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var pullUpView: UIView!
    @IBOutlet weak var pullUpViewConstraint: NSLayoutConstraint!
    
    // Variables
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 1000
    var screensize = UIScreen.main.bounds
    var flickrImages = [FlickrImage]()
    var imageArray = [UIImage]()
    // Pull Up View Objects
    var spinner: UIActivityIndicatorView?
    var lblProgress: UILabel?
    var flowLayout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView?
    
    // View Function
    override func viewDidLoad() {
        super.viewDidLoad()

        MapView.delegate = self
        locationManager.delegate = self
        
        configureLocationServices()
        
        addDoubleTap()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        registerForPreviewing(with: self, sourceView: collectionView!)
        
        pullUpView.addSubview(collectionView!)
    }

    // Actions
    @IBAction func onLocationButtonPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMap()
        }
    }
    
    // Functions
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin(sender: )))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        
        MapView.addGestureRecognizer(doubleTap)
    }
    
    func addSwipe() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(animateViewDown))
        swipe.direction = .down
        
        pullUpView.addGestureRecognizer(swipe)
    }
    
    func animateViewUp() {
        pullUpViewConstraint.constant = 300
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func animateViewDown() {
        pullUpViewConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        cancelAllSessions()
    }
    
    func addSpinner() {
        spinner = UIActivityIndicatorView()
        
        spinner?.center = CGPoint(x: screensize.width / 2 - spinner!.frame.width / 2, y: 150)
        spinner?.activityIndicatorViewStyle = .whiteLarge
        spinner?.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        spinner?.startAnimating()
        
        collectionView?.addSubview(spinner!)
    }
    
    func removeSpinner() {
        if spinner != nil {
            spinner?.removeFromSuperview()
        }
    }
    
    func addLblProgress() {
        lblProgress = UILabel()
        
        lblProgress?.frame = CGRect(x: 0, y: 175, width: screensize.width, height: 40)
        lblProgress?.font = UIFont(name: "Avenir Next", size: 18)
        lblProgress?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        lblProgress?.textAlignment = .center
        
        collectionView?.addSubview(lblProgress!)
    }
    
    func removeLblProgress() {
        if lblProgress != nil {
            lblProgress?.removeFromSuperview()
        }
    }
}

extension vcMap: MKMapViewDelegate {
    // Functions
    func centerMap() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius * 2, regionRadius * 2)
        
        MapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc func dropPin(sender: UITapGestureRecognizer) {
        cancelAllSessions()
        removePin()
        removeSpinner()
        removeLblProgress()
        
        flickrImages = []
        imageArray = []
        collectionView?.reloadData()
        
        let touchPoint = sender.location(in: MapView)
        let touchCoordinate = MapView.convert(touchPoint, toCoordinateFrom: MapView)
        
        let annotation = DropbalePin(coordinate: touchCoordinate, identifier: "dropablePin")
        
        MapView.addAnnotation(annotation)
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(touchCoordinate, regionRadius * 2, regionRadius * 2)
        
        MapView.setRegion(coordinateRegion, animated: true)
        
        animateViewUp()
        addSwipe()
        addSpinner()
        addLblProgress()
        
        retriveURLs(forAnnotation: annotation) { (finished) in
            if finished {
                self.retriveImages(handler: { (success) in
                    if success {
                        self.removeSpinner()
                        self.removeLblProgress()
                        
                        self.collectionView?.reloadData()
                    }
                })
            }
        }
    }
    
    func removePin() {
        for annotation in MapView.annotations {
            MapView.removeAnnotation(annotation)
        }
    }
    
    func retriveURLs(forAnnotation annotation: DropbalePin, handler: @escaping CompletionHandler) {
        Alamofire.request(FLICKR_URL(forAPIKey: FLICKR_API_KEY, withAnnotation: annotation, andNumberOfPhotos: 40)).responseJSON { (response) in
            guard let json = response.result.value as? Dictionary<String, AnyObject> else { return }
            
            let photosDict = json["photos"] as! Dictionary<String, AnyObject>
            let photosDictArray = photosDict["photo"] as! [Dictionary<String, AnyObject>]
            
            for photo in photosDictArray {
                var newImage = FlickrImage()
                newImage.imageURL = FLICKR_POST_URL(farm: photo["farm"]!, server: photo["server"]!, id: photo["id"]!, secret: photo["secret"]!)
                newImage.title = photo["title"] as? String
                
                let userID = photo["owner"] as? String
                newImage.user = userID
                
                self.flickrImages.append(newImage)
            }
            
            
            
            handler(true)
        }
    }
    
    func retriveImages(handler: @escaping CompletionHandler) {
        for image in flickrImages {
            Alamofire.request(image.imageURL!).responseImage(completionHandler: { (response) in
                guard let imageTo = response.result.value else { return }
                
                self.imageArray.append(imageTo)
                
                self.lblProgress?.text = "\(self.imageArray.count) Images Downloaded"
                
                if self.flickrImages.count == self.imageArray.count {
                    handler(true)
                }
            })
        }
    }
    
    
    
    func cancelAllSessions() {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach({ $0.cancel() })
            downloadData.forEach({ $0.cancel() })
        }
    }
    
    // Protocols
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "dropablePin")
        
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
        pinAnnotation.animatesDrop = true
        
        return pinAnnotation
    }
}

extension vcMap: CLLocationManagerDelegate {
    func configureLocationServices() {
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMap()
    }
}

extension vcMap: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.flickrImages.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        print("Unwrapping \(indexPath.row)")
        let imageFromIndex = imageArray[indexPath.row]
        let imageView = UIImageView(image: imageFromIndex)
        
        photoCell.addSubview(imageView)
        
        return photoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vcPop = storyboard?.instantiateViewController(withIdentifier: "vcPop") as? vcPop else { return }
        
        vcPop.initData(data: flickrImages[indexPath.row], forImage: imageArray[indexPath.row])
        
        present(vcPop, animated: true, completion: nil)
    }
}

extension vcMap: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = collectionView?.indexPathForItem(at: location), let cell = collectionView?.cellForItem(at: indexPath) else { return nil }
        
        guard let vcPop = storyboard?.instantiateViewController(withIdentifier: "vcPop") as? vcPop else { return nil }
        vcPop.initData(data: flickrImages[indexPath.row], forImage: imageArray[indexPath.row])
        
        previewingContext.sourceRect = cell.contentView.frame
        
        return vcPop
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    
    
}
