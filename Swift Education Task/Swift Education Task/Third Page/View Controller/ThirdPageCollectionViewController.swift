//
//  ThirdPageCollectionViewController.swift
//  Swift Education Task
//
//  Created by Sean Shlimak on 28/10/2021.
//

import UIKit
import Reusable

class ThirdPageCollectionViewController: UIViewController, Reusable
{
    //MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    private var presenter   : ThirdPagePresenter?
    
    /// Custom initializer
    init(presenter: ThirdPagePresenter, coordinator: ThirdPageCoordinator)
    {
        super.init(nibName: nil, bundle: nil)
        self.presenter                  = presenter
        self.presenter?.delegate        = self
        self.presenter?.coordinator    = coordinator
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpCollectionView()
        addLongGestureRecognizerToCollectionView()
    }
    
    //MARK: - Private methods
    private func setUpCollectionView()
    {
        collectionView.dataSource   = self
        collectionView.delegate     = self
        registerCollectionViewCell()
    }
    
    private func registerCollectionViewCell()
    {
        collectionView.register(cellType: ThirdPageCollectionViewCell.self)
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
        let point           = gesture.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
        DispatchQueue.main.async
        { [weak self] in
            self?.presenter?.userDidLongPressInCell()
            self?.collectionView.deleteItems(at: [indexPath])
            self?.collectionView.layoutIfNeeded()
        }
    }
}

extension ThirdPageCollectionViewController: ThirdPagePresenterProtocol{}

//MARK: - CollectionView data source + delegate handling
extension ThirdPageCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return presenter?.getNumberOfRowsInSection(section: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell                = collectionView.dequeueReusableCell(for: indexPath) as ThirdPageCollectionViewCell
        guard let cellPresenter = presenter?.getCellPresenter(for: indexPath) else { return cell }
        cell.configure(with: cellPresenter)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        presenter?.userDidSelectItem()
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension ThirdPageCollectionViewController: UIGestureRecognizerDelegate{}
