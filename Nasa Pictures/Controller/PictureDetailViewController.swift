import UIKit

class PictureDetailViewControllerDetail: UIViewController {
    
    var sonda: String?
    var imageURL: String?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageUrl: URL = URL(string: imageURL!)!
        let imageData: Data
        
        name.text = sonda
        
        do {
            imageData = try! Data(contentsOf: imageUrl)
            if let image = UIImage(data: imageData as Data) {
                picture.image = image
            }
        } catch {
            print("erro")
        }
    }    
}
