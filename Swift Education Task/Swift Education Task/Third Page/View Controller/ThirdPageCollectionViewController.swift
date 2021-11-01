//
//  ThirdPageCollectionViewController.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 28/10/2021.
//

import UIKit

class ThirdPageCollectionViewController: UIViewController
{
    //MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    private lazy var presenter = ThirdPagePresenter(delegate: self)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView.dataSource   = self
        collectionView.delegate     = self
        addLongGestureRecognizerToCollectionView()
        registerCollectionViewCell()
    }
    
    //MARK: - Private methods
    private func registerCollectionViewCell()
    {
        collectionView.register(UINib(nibName: "ThirdPageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ThirdPageCell")
    }
    
    private func addLongGestureRecognizerToCollectionView()
    {
        let longPressGesture                    = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_ :)))
        longPressGesture.minimumPressDuration   = 1.0
        longPressGesture.delegate               = self
        longPressGesture.delaysTouchesBegan     = true
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer)
    {
        if gesture.state != .ended
        {
            return
        }
        let point           = gesture.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
        DispatchQueue.main.async
        { [weak self] in
            self?.presenter.removeOneCellFromTotalCount()
            self?.collectionView.deleteItems(at: [indexPath])
            self?.collectionView.layoutIfNeeded()
        }
    }
    
    //MARK: - Public methods
    func setNumberOfCells(number: Int)
    {
        presenter.setNumberOfCells(number: number)
    }
}

extension ThirdPageCollectionViewController: ThirdPagePresenterProtocol
{
    
}

//MARK: - CollectionView data source + delegate handling
extension ThirdPageCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.getNumberOfRowsInSection(section: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell                = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdPageCell", for: indexPath)
        
        if let thirdPageCell    = cell as? ThirdPageCollectionViewCell
        {
            guard let cellPresenter = presenter.getCellPresenter(for: indexPath) else { return cell }
            thirdPageCell.configure(with: cellPresenter)
            return thirdPageCell
        }
        return cell
    }
}

extension ThirdPageCollectionViewController: UIGestureRecognizerDelegate{}
