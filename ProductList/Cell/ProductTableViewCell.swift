//
//  ProductTableViewCell.swift
//  ProductList
//
//  Created by Jarae on 19/6/23.
//

import UIKit
import SnapKit

class ProductTableViewCell: UITableViewCell {

    static let reuseId = String(describing: ProductTableViewCell.self)
    
    private var productImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        return view
    }()
    
    private var productName: UILabel = {
        let view = UILabel()
        view.textColor = .label
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 22)
        return view
    }()
    private var productPrice: UILabel = {
        let view = UILabel()
        view.textColor = .label
        view.font = .systemFont(ofSize: 17)
        return view
    }()
    
    private var productRating: UILabel = {
        let view = UILabel()
        view.textColor = .label
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    private var ratingImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = .orange
        return view
    }()
    
    private var productDescription: UILabel = {
        let view = UILabel()
        view.textColor = .label
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 15)
        view.numberOfLines = 0
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI()
        contentView.layer.cornerRadius = 15
        // Configure the view for the selected state
    }
    
    public func display(with: Product){
        productName.text = with.title
        productDescription.text = with.description

        DispatchQueue.global(qos: .userInitiated).async {
            guard let data = ImageDownloader(
                urlString: with.thumbnail
            ).donwload()
            else {
                return
            }
            DispatchQueue.main.async {
                self.productImage.image = UIImage(data: data)
            }
        }
    }
    private func setupUI() {
        
        contentView.addSubview(productImage)
        productImage.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(180)
        }
        
        contentView.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        contentView.addSubview(productPrice)
        productPrice.snp.makeConstraints { make in
            make.left.equalTo(productName.snp.left).offset(10)
            make.top.equalTo(productImage.snp.bottom).offset(10)
        }
        
        contentView.addSubview(productDescription)
        productDescription.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(productName.snp.bottom).offset(10)
        }
    }

}
