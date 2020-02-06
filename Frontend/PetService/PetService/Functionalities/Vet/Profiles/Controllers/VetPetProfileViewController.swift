//
//  VetPetProfileViewController.swift
//  PetService
//
//  Created by Dusan Milic on 04/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class VetPetProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, petSelectedProtocol {
    
    @IBOutlet weak var topBar: UICollectionView!
    @IBOutlet weak var profileViewsCollectionBar: UICollectionView!
    var delegate: reloadDataProtocol?
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    var images: [Picture] = []
    var galleryCell: VetGalleryViewCollectionViewCell?
    var medicalCell: VetMedicalCollectionViewCell?
    var delegate2: imageToViewSelectedProtocol?
    var pet: Dog?
    var delegate1: petSelectedProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topBar.delegate = self
        self.topBar.dataSource = self
        self.profileViewsCollectionBar.delegate = self
        self.profileViewsCollectionBar.dataSource = self
        self.profileViewsCollectionBar.isPagingEnabled = true
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        if let flowLayout = profileViewsCollectionBar.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }

        ApiService.sharedInstance.getAllImagesForPet(petId: self.pet!.id) { (images:[Picture]?) in
            if(images != nil){
                self.images = images!
                self.galleryCell?.galleryCollectionView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let selectedItemIndexPath = IndexPath(item: 0, section: 0);
        topBar.selectItem(at: selectedItemIndexPath, animated: false
            , scrollPosition: UICollectionView.ScrollPosition.left)
        setupHorizontalBar();
    }
    
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
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    func ScrollToMenuIndex(menuIndex: Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        profileViewsCollectionBar.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x/4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.topBar || collectionView == self.profileViewsCollectionBar){
            return 4
        } else {
            return self.images.count
        }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if(collectionView == topBar){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VetConstants.profileTopbarCellId, for: indexPath)
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
                if(collectionView == self.profileViewsCollectionBar){
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VetConstants.profileViewsCellIds[indexPath.item], for: indexPath)
                    if(indexPath.item == 0){
                        self.setBasicInfo(cell: cell, indexPath: indexPath)
                    }
                    if(indexPath.item == 1){
                        self.setAdditionalInfo(cell: cell, indexPath: indexPath)
                    }
                    if(indexPath.item == 2){
                        self.setMedicalInfo(cell: cell, indexPath: indexPath)
                        self.delegate1 = (cell as! VetMedicalCollectionViewCell)
                        self.delegate1?.petSelected(pet: self.pet!, imageId: 1)
                    }
                    if(indexPath.item == 3){
                        self.galleryCell = (cell as! VetGalleryViewCollectionViewCell)
                    }
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
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
        
        if(self.pet!.picture != nil){
            imageView.image = UIImage(data: self.pet!.picture!.photo)
        }
        dogsNameLabel.text = self.pet!.name
        dogsAgeLabel.text = "\(String(Calendar.current.component(.year, from: Date()) - self.pet!.yearOfBirth)) years old"
        dogsDateOfBirthLabel.text = String(self.pet!.yearOfBirth)
        dogsWeightLabel.text = String(self.pet!.weight)
        dogsGenderLabel.text = self.pet!.genre
        dogsSpeciesLabel.text = self.pet!.species
        dogsBreedLabel.text = self.pet!.breed
    }
    
    func setAdditionalInfo(cell: UICollectionViewCell, indexPath: IndexPath){
        let addInfo: PetAdditionalInfo? = self.pet?.additionalInfo
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
        let medicalFile: MedicalFile? = self.pet!.medicalInfo
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
        if(collectionView == topBar || collectionView == profileViewsCollectionBar){
            self.ScrollToMenuIndex(menuIndex: indexPath.item)
        } else{
            let pc: ImageGalleryViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "imagePopUpId") as! ImageGalleryViewController
            self.addChild(pc)
            pc.view.frame = self.view.frame
            self.tabBarController?.tabBar.isHidden = true
            self.delegate2 = pc
            self.delegate2?.imageSelected(imageToPresent: UIImage(data: self.images[indexPath.item].photo)!)
            self.view.addSubview(pc.view)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == topBar){
            return CGSize.init(width: collectionView.frame.width / 4.1, height: collectionView.frame.height)
        } else {
            if(collectionView == self.profileViewsCollectionBar){
            return CGSize.init(width: collectionView.frame.width, height: collectionView.frame.height)
            } else {
                return CGSize.init(width: collectionView.frame.width / 4, height: collectionView.frame.height / 5)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.parent!.navigationController!.setNavigationBarHidden(false, animated: true)
        removeFromParent()
        self.view.removeFromSuperview()
    }
    
    
    func petSelected(pet: Dog, imageId: CLong) {
        self.pet = pet
        ApiService.sharedInstance.getProfilePicture(id: imageId) { (picture: Picture?) in
            self.pet!.picture = picture
            self.profileViewsCollectionBar.reloadData()
        }
    }
}
