import UIKit
import WebKit
import AVKit

class VideoTestViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //https://www.youtube.com/watch?v=xwwAVRyNmgQ
        //https://youtu.be/xwwAVRyNmgQ
        
        let url = "https://www.youtube.com/watch?v=xwwAVRyNmgQ"
        
        //Get video ID
        let img = getThumbnailFromVideoUrl(urlString: "https://www.youtube.com/watch?v=QuyO_-LA-YU")
         do {
         let regex = try NSRegularExpression(pattern: "(?<=v(=|/))([-a-zA-Z0-9_]+)|(?<=youtu.be/)([-a-zA-Z0-9_]+)", options: .caseInsensitive)
         let match = regex.firstMatch(in: url, options: .reportProgress, range: NSMakeRange(0, url.lengthOfBytes(using: String.Encoding.utf8)))
         let range = match?.range(at: 0)
         let youTubeID = (url as NSString).substring(with: range!)
         } catch {
         print(error)
         }
        
        
         //Other method to get video ID using extension
         print(url.youtubeID as Any)
        
        loadYoutube(videoID: "QuyO_-LA-YU")
        //genarateThumbnailFromYouTubeID(youTubeID: youTubeID)
        //getThumbnailFromVideoUrl(urlString: url)
        
    }
    
    //MARK:- Play Video
    
    func loadYoutube(videoID:String) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else {
            return
        }
        webView.load(URLRequest(url: youtubeURL))
    }
    
    //MARK:- Generate Thumbnail Functions
    
    func genarateThumbnailFromYouTubeID(youTubeID: String) {
        let urlString = "http://img.youtube.com/vi/\(youTubeID)/1.jpg"
        let image = try! (UIImage(withContentsOfUrl: urlString))!
    }
    
    func getThumbnailFromVideoUrl(urlString: String) {
        DispatchQueue.global().async {
            let asset = AVAsset(url: URL(string: urlString)!)
            let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            assetImgGenerate.appliesPreferredTrackTransform = true
            let time = CMTimeMake(value: 1, timescale: 20)
            let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            if img != nil {
                let frameImg  = UIImage(cgImage: img!)
                DispatchQueue.main.async(execute: {
                    // assign your image to UIImageView
                })
            }
        }
    }

}

extension UIImage {
    convenience init?(withContentsOfUrl imageUrlString: String) throws {
        let imageUrl = URL(string: imageUrlString)!
        let imageData = try Data(contentsOf: imageUrl)
        
        self.init(data: imageData)
    }
    
}

extension String {
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
    
}
