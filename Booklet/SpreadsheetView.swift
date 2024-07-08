import Cocoa

class SpreadsheetView: NSView, NSCollectionViewDataSource, NSCollectionViewDelegate {
    let rows: Int = 40
    let columns: Int = 40
    
    private lazy var collectionView: NSCollectionView = {
        let layout = NSCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let cv = NSCollectionView()
        cv.collectionViewLayout = layout
        cv.dataSource = self
        cv.delegate = self
        cv.isSelectable = true
        cv.allowsMultipleSelection = false
        
        return cv
    }()
    
    private lazy var scrollView: NSScrollView = {
        let sv = NSScrollView()
        sv.documentView = collectionView
        sv.hasVerticalScroller = true
        sv.hasHorizontalScroller = true
        return sv
    }()
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        collectionView.register(CellItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier("CellItem"))
        scrollView.displayIfNeeded()
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return rows
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return columns
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("CellItem"), for: indexPath)
        if let cellItem = item as? CellItem {
            cellItem.textField?.stringValue = "R\(indexPath.section)C\(indexPath.item)"
        }
        return item
    }
}

class CellItem: NSCollectionViewItem {
    override func loadView() {
        super.loadView()
        self.view = NSTextField(frame: NSRect(x: 0, y: 0, width: 100, height: 25))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let textField = self.view as? NSTextField {
            textField.isEditable = true
            textField.isBordered = true
            textField.drawsBackground = true
            textField.backgroundColor = .white
            textField.alignment = .center
        }
    }
}
