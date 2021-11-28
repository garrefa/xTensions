
import UIKit

// MARK: - Dequeues Helpers

public extension UICollectionView {
    /// Dequeues a reusable UICollectionViewCell of the given type.
    /// Uses the class name as the reuse id to retrieve the cell.
    ///
    /// - Parameters:
    ///   - type: UICollectionViewCell subclass type to retrieve
    ///   - indexPath: The index path specifying the location of the cell
    /// - Returns: a UICollectionViewCell already casted to the correct type or nil

    func reusableCell<T: UICollectionViewCell>(type: T.Type, for indexPath: IndexPath) -> T {
        let className = String(describing: type)
        if let cell = dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? T {
            return cell
        }
        fatalError("Unable to dequeue cell")
    }

    /// Dequeues a reusable supplementary view of the given type.
    /// Uses the class name as the reuse id to retrieve the view.
    ///
    /// - Parameters:
    ///   - type: UICollectionReusableView subclass type to retrieve
    ///   - kind: The kind of supplementary view to retrieve
    ///   - indexPath: The index path specifying the location of the supplementary view
    /// - Returns: a UICollectionReusableView already casted to the correct type or nil

    func reusableSupplementaryView<T: UICollectionReusableView>(
        ofType type: T.Type,
        kind: String,
        for indexPath: IndexPath
    ) -> T {
        let className = String(describing: type)
        if let reusableView = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: className,
            for: indexPath
        ) as? T {
            return reusableView
        }
        fatalError("Unable to dequeue reusable view")
    }
}

// MARK: - Register Helpers

public extension UICollectionView {
    /// Registers an array of UICollectionViewCells in the collection view.
    /// Uses the class name as the reuse id to register the cell.
    /// Will check it a nib exists with that same type name and if so will instantiate the nib
    /// and register the nib for that reuse identifier. Otherwise it will register the class type.
    /// Useful to avoid a lot of boilerplace code.
    ///
    /// - Parameters:
    ///   - types: Array of UICollectionViewCell subclass types to register

    func registerCells<T: UICollectionViewCell>(types: [T.Type]) {
        types.forEach { classType in
            registerCell(type: classType)
        }
    }

    /// Registers a single UICollectionViewCell subclass in the collection view.
    /// Uses the class name as the reuse id to register the cell.
    /// Will check it a nib exists with that same type name and if so will instantiate the nib
    /// and register the nib for that reuse identifier. Otherwise it will register the class type.
    /// Useful to avoid a lot of boilerplace code.
    ///
    /// - Parameters:
    ///   - type: UICollectionViewCell subclass type to register

    func registerCell<T: UICollectionViewCell>(type: T.Type) {
        let identifier = String(describing: type)
        let bundle = Bundle(for: type)
        if bundle.path(forResource: identifier, ofType: "nib") != nil {
            let nib = UINib(nibName: identifier, bundle: bundle)
            register(nib, forCellWithReuseIdentifier: identifier)
            return
        }
        register(type, forCellWithReuseIdentifier: identifier)
    }

    /// Registers a single supplementary view subclass in the collection view.
    /// Uses the class name as the reuse id to register the view.
    /// Will check it a nib exists with that same type name and if so will instantiate the nib
    /// and register the nib for that reuse identifier. Otherwise it will register the class type.
    /// Useful to avoid a lot of boilerplace code.
    ///
    /// - Parameters:
    ///   - type: UICollectionReusableView subclass type to register
    ///   - kind: The kind of supplementary view to create

    func registerSupplementaryView<T: UICollectionReusableView>(type: T.Type, kind: String) {
        let identifier = String(describing: type)
        let bundle = Bundle(for: type)
        if bundle.path(forResource: identifier, ofType: "nib") != nil {
            let nib = UINib(nibName: identifier, bundle: bundle)
            register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
            return
        }
        register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }
}

