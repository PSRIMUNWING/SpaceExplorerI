//
//  ImageCell.swift
//  SpaceExplorerI
//
//  Created by PSRIMUNWING on 2/3/2569 BE.
//

import UIKit
import Kingfisher
import RxSwift

class ImageCell: UITableViewCell {
    
    static let identifier = "ImageCell"
    @IBOutlet weak var imageToday: UIImageView!
    @IBOutlet weak var viewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        backgroundColor = .clear
//        contentView.backgroundColor = .clear
        viewCell.backgroundColor = .clear
        viewCell.layer.cornerRadius = 10
        viewCell.layer.masksToBounds = true
    }
    
    func configure(with urlString: String) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            guard let self = self, let url = URL(string: urlString) else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            self.imageToday.kf.indicatorType = .none // 👈 remove kf spinner, we use our own loader
            self.imageToday.kf.setImage(
                with: url,
                placeholder: nil, // 👈 no placeholder, keep loading visible
                options: [.transition(.fade(0.3))]
            ) { result in
                switch result {
                case .success:
                    observer.onNext(()) // 👈 only fires when real image is ready
                case .failure:
                    observer.onNext(()) // 👈 still dismiss loading on error
                }
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
}
