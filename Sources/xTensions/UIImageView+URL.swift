
import UIKit

public let imageCache = NSCache<NSString, UIImage>()

public extension UIImageView {
    @discardableResult
    func loadImage(from urlString: String, placeholder: UIImage? = nil) -> URLSessionDataTask? {

        self.image = nil

        let cacheKey = NSString(string: urlString)
        if let cachedImage = imageCache.object(forKey: cacheKey) {
            self.image = cachedImage
            return nil
        }

        guard let url = URL(string: urlString) else {
            print("Invalid image url: \(urlString)")
            return nil
        }

        self.image = placeholder

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                print("Failed to load image from \(urlString): \(error!.localizedDescription)")
                return
            }

            DispatchQueue.main.async {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(downloadedImage, forKey: cacheKey)
                    self.image = downloadedImage
                }
            }
        }

        task.resume()
        return task
    }
}
