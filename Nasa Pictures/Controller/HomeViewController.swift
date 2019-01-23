import UIKit

class PicturesCollectionCell: UICollectionViewCell {
    @IBOutlet weak var picture: UIImageView!
}

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var dateIndex: Int = 0
    let date = Date()
    var loopEnd: Bool = false
    var inRequisition: Bool = false
    var sonda: String = "curiosity"
    var index: Int?
    var curiosity: Result?
    var opportunity: Result?
    var spirit: Result?
    
    @IBOutlet weak var picturesCollectionView: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picturesCollectionView.delegate = self
        self.picturesCollectionView.dataSource = self
        
        getPictures()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Screen.screenWidth*48/100, height: Screen.screenHeight*24/100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if sonda.elementsEqual("curiosity"){
            if curiosity != nil {
                return (curiosity?.photos?.count)!
            } else {
                return 0
            }
        } else if sonda.elementsEqual("opportunity") {
            if opportunity != nil {
                return (opportunity?.photos?.count)!
            } else {
                return 0
            }
        } else if sonda.elementsEqual("spirit")  {
            if spirit != nil {
                return (spirit?.photos?.count)!
            } else {
                return 0
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PicturesCollectionCell
        
        var imageUrlString: String = ""
        cell.picture.tag = indexPath.item
        
        if sonda.elementsEqual("curiosity"){
            imageUrlString = (self.curiosity?.photos?[indexPath.item].img_src)!
        } else if sonda.elementsEqual("opportunity") {
            imageUrlString = (self.opportunity?.photos?[indexPath.item].img_src)!
        } else {
            imageUrlString = (self.spirit?.photos?[indexPath.item].img_src)!
        }
        
        let imageUrl: URL = URL(string: imageUrlString)!
        let imageData: Data
        
        do {
            imageData = try! Data(contentsOf: imageUrl)
            if let image = UIImage(data: imageData as Data) {
                cell.picture.image = image
            }
        } catch {
            print("erro")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.item
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    func getPictures() {
        repeat {
            if inRequisition == false {
                inRequisition = true
                self.dateIndex = self.dateIndex - 1
                print(Calendar.current.date(byAdding: .day, value: self.dateIndex, to: date))
                OTMClient.sharedInstance().getData(sonda: sonda, starterDate: Calendar.current.date(byAdding: .day, value: self.dateIndex, to: date)!) { (success, error) in
                    if error == nil {
                        if (success?.photos?.count)! > 0 {
                            if self.sonda.elementsEqual("curiosity") {
                                self.curiosity = success
                                self.sonda = "opportunity"
                                self.picturesCollectionView.reloadData()
                            } else if self.sonda == "opportunity" {
                                self.dateIndex = 0
                                self.opportunity = success
                                self.sonda = "spirit"
                                self.loopEnd = true
                                DispatchQueue.main.sync {
                                    self.sonda = "curiosity"
                                    self.picturesCollectionView.reloadData()
                                }
                            } else {
                                self.dateIndex = 0
                                self.spirit = success
                                self.loopEnd = true                                
                            }
                            self.inRequisition = false
                        } else {
                            self.inRequisition = false
                        }
                    } else {
                        self.inRequisition = false
                        if (error?.localizedDescription.elementsEqual("limit"))! {
                            self.loopEnd = true
                            DispatchQueue.main.sync {
                                Toast.toastMessage("número de requisições máximas alcançadas. Pode ser que alguma sonda fique sem nenhuma foto!")
                            }
                        }
                    }
                }
            }
        } while loopEnd == false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            let newViewController = segue.destination as! PictureDetailViewControllerDetail
            newViewController.sonda = sonda
            
            if sonda.elementsEqual("curiosity"){
                newViewController.imageURL = self.curiosity?.photos?[index!].img_src
            } else if sonda.elementsEqual("opportunity") {
                newViewController.imageURL = self.opportunity?.photos?[index!].img_src
            } else {
                newViewController.imageURL = self.spirit?.photos?[index!].img_src
            }
            
        }
    }
    
    @IBAction func change(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            sonda = "curiosity"
        } else if sender.selectedSegmentIndex == 1 {
            sonda = "opportunity"
        } else {
            sonda = "spirit"
        }
        self.picturesCollectionView.reloadData()
    }
    
}

