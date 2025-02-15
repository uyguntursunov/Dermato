//
//  ProductsTableViewCell.swift
//  Curify
//
//  
//

import UIKit

struct Product {
    let title: String
    let imgString: String
    let cost: String
    let seller: String
}

class ProductsTableViewCell: UITableViewCell {
    
    var itemHeight: CGFloat = 0
    var itemWidth: CGFloat = 0
    var numberOfItems: Int = 0
    
    let products = [
        Product(title: "Ordinary", imgString: "product", cost: "54000 UZS", seller: "uzum.uz"),
        Product(title: "Azafran", imgString: "product2", cost: "48000 UZS", seller: "alifshop.uz"),
        Product(title: "Byoma", imgString: "product3", cost: "112000 UZS", seller: "uzum.uz"),
        Product(title: "Tea Tree", imgString: "product4", cost: "37000 UZS", seller: "aliexpress.ru")
    ]
    
    lazy var subView = SubView(frame: .zero)
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 20
//        layout.minimumInteritemSpacing = 0
        //        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        //        collectionView.isScrollEnabled = false
        //        collectionView.layer.cornerRadius = 12
        collectionView.showsHorizontalScrollIndicator = false
        //        collectionView.isUserInteractionEnabled = false
        //        collectionView.isScrollEnabled = false
        collectionView.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: String.init(describing: ProductsCollectionViewCell.self))
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.frame
    }
    
    func initViews() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(225)
            
            //            if meals.count % 2 == 0 {
            //                make.height.equalTo(205 * (meals.count / 2))
            //            } else {
            //                make.height.equalTo(205 * ((meals.count / 2) + 1))
            //            }
        }
    }
    
    func setData(numberOfItems: Int) {
        self.numberOfItems = numberOfItems
    }
}

extension ProductsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: ProductsCollectionViewCell.self), for: indexPath) as? ProductsCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(product: products[indexPath.item])
        //        cell.setMeal(meal: meals[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        itemHeight = 225
        itemWidth = (UIScreen.main.bounds.width - 90) / 2
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

