//
//  PetProfileViewController.swift
//  PetService
//
//  Created by Dusan Milic on 26/09/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

protocol imageToViewSelectedProtocol: class {
    func imageSelected(imageToPresent image: UIImage)
}

class PetProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, addMeasureProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate, savedAdditionalInfoProtocol {
    func savedInfo() {
        self.profileViews.reloadData()
    }
    
    
    func addMeasureViewControllerDidCancel(_ controller: PetProfilePopUpViewController) {
        delegate?.addMeasureViewControllerDidCancel(controller)
    }
    
    func addMeasureViewController(_ controller: PetProfilePopUpViewController, didFinishAdding measure: Measurement) {
        delegate?.addMeasureViewController(controller, didFinishAdding: measure)
    }
    
    
    @IBOutlet weak var topBar: UICollectionView!
    @IBOutlet weak var profileViews: UICollectionView!
    var delegate: reloadDataProtocol?
    var delegate2: imageToViewSelectedProtocol?
    var galeryCell: GalleryCollectionViewCell?
    var medicalCell: MedicalCollectionViewCell?
    
    let cellId = "cellId"
    let cell2Id = "cell2Id"
    
    var images: [Picture] = []
    let imagePicker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Pet profile"
        topBar.delegate = self
        topBar.dataSource = self
        
        profileViews.delegate = self
        profileViews.dataSource = self
        profileViews.isPagingEnabled = true
        if let flowLayout = profileViews.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        ApiService.sharedInstance.getAllImagesForPet(petId: System.shared().getActiveDog()!.id) { (pictures:[Picture]?) in
            if(pictures != nil){
                self.images = pictures!
                self.galeryCell?.galleryCollectionView.reloadData()
            }
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData(_:)), name: Notification.Name(rawValue: "refreshData"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func refreshData(_ notification: Notification){
        self.profileViews.reloadData()
        ApiService.sharedInstance.getAllImagesForPet(petId: System.shared().getActiveDog()!.id) { (pictures:[Picture]?) in
            if(pictures != nil){
                self.images = pictures!
            } else{
                self.images = []
            }
            self.galeryCell?.galleryCollectionView.reloadData()
        }
        self.medicalCell?.getMeasures()
    }
    
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    func setupHorizontalBar(){
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor.white
        horizontalBarView.alpha = 0.95
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(horizontalBarView)
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: topBar.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: topBar.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == topBar || collectionView == profileViews){
            return 4
        } else {
            return images.count
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let selectedItemIndexPath = IndexPath(item: 0, section: 0);
        topBar.selectItem(at: selectedItemIndexPath, animated: false
            , scrollPosition: UICollectionView.ScrollPosition.left)
        setupHorizontalBar();
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == topBar){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = UIColor.lightGray
            let label: UILabel = cell.viewWithTag(911) as! UILabel
            label.textColor = UIColor.white
            switch indexPath.row {
            case 0:
                label.text = "Basic"
                break
            case 1:
                label.text = "Detail"
                break
            case 2:
                label.text = "Medical"
                break
            case 3:
                label.text = "Gallery"
                break
            default:
                break;
            }
            return cell
        } else {
            if(collectionView == self.profileViews){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.petProfileCellIds[indexPath.item], for: indexPath)
                if(indexPath.item == 0){
                    self.setBasicInfo(cell: cell, indexPath: indexPath)
                }
                if(indexPath.item == 1){
                    self.setAdditionalInfo(cell: cell, indexPath: indexPath)
                }
                if(indexPath.item == 2){
                    self.setMedicalInfo(cell: cell, indexPath: indexPath)
                    self.delegate = (cell as! MedicalCollectionViewCell)
                    self.medicalCell = (cell as! MedicalCollectionViewCell)
                }
                if(indexPath.item == 3){
                    self.galeryCell = (cell as! GalleryCollectionViewCell)
                }
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
                let imageView: UIImageView = cell.viewWithTag(1) as! UIImageView
                imageView.image = UIImage(data: images[indexPath.item].photo)
                return cell
            }
        }
    }
    
    func setBasicInfo(cell: UICollectionViewCell, indexPath: IndexPath){
        let imageView: UIImageView = cell.viewWithTag(Constants.petProfileTags[indexPath.item][0]) as! UIImageView
        let dogsNameLabel: UILabel = cell.viewWithTag(Constants.petProfileTags[indexPath.item][1]) as! UILabel
        let dogsAgeLabel: UILabel = cell.viewWithTag(Constants.petProfileTags[indexPath.item][2]) as! UILabel
        let dogsDateOfBirthLabel: UILabel = cell.viewWithTag(Constants.petProfileTags[indexPath.item][3]) as! UILabel
        let dogsWeightLabel: UILabel = cell.viewWithTag(Constants.petProfileTags[indexPath.item][4]) as! UILabel
        let dogsGenderLabel: UILabel = cell.viewWithTag(Constants.petProfileTags[indexPath.item][5]) as! UILabel
        let dogsSpeciesLabel: UILabel = cell.viewWithTag(Constants.petProfileTags[indexPath.item][6]) as! UILabel
        let dogsBreedLabel: UILabel = cell.viewWithTag(Constants.petProfileTags[indexPath.item][7]) as! UILabel
        
        let activeDog: Dog? = System.shared().getActiveDog();
        
        if(System.shared().getActiveDog()!.picture != nil){
        imageView.image = UIImage(data: activeDog!.picture!.photo)
        }
        dogsNameLabel.text = activeDog!.name
        dogsAgeLabel.text = "\(String(Calendar.current.component(.year, from: Date()) - activeDog!.yearOfBirth)) years old"
        dogsDateOfBirthLabel.text = String(activeDog!.yearOfBirth)
        dogsWeightLabel.text = String(activeDog!.weight)
        dogsGenderLabel.text = activeDog!.genre
        dogsSpeciesLabel.text = activeDog!.species
        dogsBreedLabel.text = activeDog!.breed
    }
    
    func setAdditionalInfo(cell: UICollectionViewCell, indexPath: IndexPath){
        let addInfo: PetAdditionalInfo? = System.shared().getActiveDog()!.additionalInfo
        let doorLabel: UILabel = cell.viewWithTag(Constants.petProfileTags[indexPath.item][0]) as! UILabel
        let foodTypeLabel: UILabel = cell.viewWithTag(Constants.petProfileTags[indexPath.item][1]) as! UILabel
        let mealSizeLabel: UILabel = cell.viewWithTag(Constants.petProfileTags[indexPath.item][2]) as! UILabel
        let mealsPerDayLabel: UILabel = cell.viewWithTag(Constants.petProfileTags[indexPath.item][3]) as! UILabel
        let physicalActivityLabel: UILabel = cell.viewWithTag(Constants.petProfileTags[indexPath.item][4]) as! UILabel
        let travelingLabel: UILabel = cell.viewWithTag(Constants.petProfileTags[indexPath.item][5]) as! UILabel
        
        self.setLabelText(label: doorLabel, text: addInfo?.indoor)
        self.setLabelText(label: foodTypeLabel, text: addInfo?.food_type)
        self.setLabelText(label: mealSizeLabel, text: addInfo?.meal_size)
        self.setLabelText(label: mealsPerDayLabel, text: addInfo?.meals_per_day)
        self.setLabelText(label: physicalActivityLabel, text: addInfo?.physical_activity)
        self.setLabelText(label: travelingLabel, text: addInfo?.traveling)
    }
    
    func setMedicalInfo(cell: UICollectionViewCell, indexPath: IndexPath){
        let medicalFile: MedicalFile? = System.shared().getActiveDog()!.medicalInfo
        let disseasesLabel: UILabel = cell.viewWithTag(Constants.petProfileTags[indexPath.item][0]) as! UILabel
        let allergiesLabel: UILabel = cell.viewWithTag(Constants.petProfileTags[indexPath.item][1]) as! UILabel
        let treatmentsLabel: UILabel = cell.viewWithTag(Constants.petProfileTags[indexPath.item][2]) as! UILabel
        
        
        self.setLabelText(label: disseasesLabel, text: medicalFile?.diseases)
        self.setLabelText(label: allergiesLabel, text: medicalFile?.allergies)
        self.setLabelText(label: treatmentsLabel, text: medicalFile?.treatments)
    }
    
    func setLabelText(label: UILabel, text: Any?){
        if(text != nil){
            label.text = String("\(text!)")
        } else {
            label.text = "-"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == topBar || collectionView == profileViews){
            self.ScrollToMenuIndex(menuIndex: indexPath.item)
        } else{
            let pc: ImageGalleryViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "imagePopUpId") as! ImageGalleryViewController
            let parent = self.parent! as! HomepageViewController
            parent.addChild(pc)
            pc.view.frame = parent.view.frame
            self.delegate2 = pc
            self.delegate2?.imageSelected(imageToPresent: UIImage(data: self.images[indexPath.item].photo)!)
            parent.view.addSubview(pc.view)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == topBar){
            return CGSize.init(width: collectionView.frame.width / 4.1, height: collectionView.frame.height)
        } else {
            if(collectionView == profileViews){
            return CGSize.init(width: collectionView.frame.width, height: collectionView.frame.height)
            } else {
                return CGSize.init(width: collectionView.frame.width / 4, height: collectionView.frame.height / 5)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func ScrollToMenuIndex(menuIndex: Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        profileViews.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x/4
    }
    
    @IBAction func addImageClicked(_ sender: Any) {
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum;
        self.present(imagePicker, animated: true, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            let newPicture: NewPicture = NewPicture(petId: System.shared().getActiveDog()!.id, picture: image.toString()!)
            ApiService.sharedInstance.addImage(newImage: newPicture) { (picture: Picture) in
                self.images.append(picture)
                self.galeryCell?.galleryCollectionView.reloadData()
            }
            
        }
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func addMeasureClicked(_ sender: Any) {
        let pc: PetProfilePopUpViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpId") as! PetProfilePopUpViewController
        self.addChild(pc)
        pc.view.frame = self.view.frame
        pc.delegate = self
        self.view.addSubview(pc.view)
    }
    
    @IBAction func addAdditionalInfoClicked(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let pc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AdditionalInfoAddSBId") as! AdditionalInfoViewController
            let parent = self.parent! as! HomepageViewController
            pc.delegate = self
            pc.view.frame = parent.view.frame
            parent.addChild(pc)
            parent.view.addSubview(pc.view)
        }
    }
}
