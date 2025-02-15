//
//  ProductsPageTableViewCell.swift
//  Dermato AI
//
//  
//

import UIKit

class ProductsPageTableViewCell: UITableViewCell {
    
    var itemHeight: CGFloat = 0
    var itemWidth: CGFloat = 0
    
    let products = [
        Product(title: "Ordinary", imgString: "product", cost: "54000 UZS", seller: "uzum.uz"),
        Product(title: "Azafran", imgString: "product2", cost: "48000 UZS", seller: "alifshop.uz"),
        Product(title: "Byoma", imgString: "product3", cost: "112000 UZS", seller: "uzum.uz"),
        Product(title: "Tea Tree", imgString: "product4", cost: "37000 UZS", seller: "aliexpress.ru")
    ]
    
    var numberOfItems: Int = 0 {
        didSet {
            collectionView.snp.updateConstraints { make in
                if numberOfItems % 2 == 0 {
                    make.height.equalTo(225 * CGFloat(numberOfItems / 2))
                } else {
                    make.height.equalTo(225 * CGFloat((numberOfItems / 2) + 1))
                }
            }
            collectionView.reloadData()
        }
    }
    
    lazy var subView = SubView(frame: .zero)
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 10
        //        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        //        collectionView.isScrollEnabled = false
        //        collectionView.layer.cornerRadius = 12
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
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
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
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

extension ProductsPageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        itemWidth = (UIScreen.main.bounds.width - 60) / 2
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
