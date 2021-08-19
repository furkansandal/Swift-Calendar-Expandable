//
//  TriwiCell.swift
//  CalendarFS
//
//  Created by Sefer Furkan Sandal  on 17.08.2021.
//

import UIKit
import FSCalendar

enum CalendarSelectionType: String, CaseIterable {
    case none
    case baslananGecmisYumurtlama = "yumurtlamaTamamlanan"
    case tahminiYumutlamaGunu = "yumurtlamaTahmini"
    case reglDonemiTek = "reglTek"
    case reglDonemiLeftBorder = "reglBaslangic"
    case reglDonemiOrta = "reglOrta"
    case reglDonemiRightBorder = "reglSon"
    case tahminiReglDonemiTek = "reglTahminiTek"
    case tahminiRegleglDonemiLeftBorder = "ReglTahminiBaslangic"
    case tahminiRegleglDonemiOrta = "reglTahminiOrta"
    case tahminiRegleglDonemiSag = "reglTahminiSon"
    case tamamlananMemeMuayenesi = "memeMuayenesiTamalanan"
    case gelecekMemeMuayeneEnIyiGun = "memeMuayenesiEnIyiGun"
    case gelecekMemeMuayenesiIcinDigerGunler = "memeMuayenesiUygunDiger"
    
}

enum CalendarTextType {
    case normal
    case yumurtlamaDonemi
    case yumurtlamaDonemiDigerAylar
    case mevcutGun
    case aylikTakvimDigerAyGunleri
}

class TriwiCell: FSCalendarCell {
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var centerImageView: UIImageView!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    var selectionType: CalendarSelectionType = .none
    var textType: CalendarTextType = .normal
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        dateLabel.text = titleLabel.text
        dateLabel.font = titleLabel.font
        if FSCalendarMonthPosition.current != monthPosition {
            dateLabel.textColor = .gray
        }
        selectedView.isHidden = !isSelected
        self.shapeLayer.isHidden = true
    }
    
    func configure(selectionType: CalendarSelectionType) {
        self.selectionType = selectionType
        layoutSubviews()
        setSelectionType(selectionType)
        setTextType(selectionType)
    }
    
    func setTextType(_ type: CalendarSelectionType) {
        if isSelected {
            dateLabel.textColor = .red
            return
        }
        if FSCalendarMonthPosition.current != monthPosition {
            dateLabel.textColor = .gray
            return
        }
        
        switch type {
        case .baslananGecmisYumurtlama:
            dateLabel.textColor = .green
        case .tahminiYumutlamaGunu:
            dateLabel.textColor = .cyan
        default:
            dateLabel.textColor = .black
        }
    }
    
    private func hideBackgrounds(_ backImage: Bool = true,_ frontImage: Bool = false) {
        backImageView.isHidden = backImage
        centerImageView.isHidden = frontImage
    }
    
    private func setImage(imageName: CalendarSelectionType, _ isBackground: Bool = false){
        if imageName == .none { return }
        let currentImage = UIImage(named: imageName.rawValue)!
        if isBackground {
            backImageView.image = currentImage
        } else {
            centerImageView.image = currentImage
        }
    }
    
    func setSelectionType(_ type: CalendarSelectionType) {
        switch type {
        case .baslananGecmisYumurtlama,.tahminiYumutlamaGunu, .reglDonemiTek,
             .tahminiReglDonemiTek, .gelecekMemeMuayeneEnIyiGun,
             .gelecekMemeMuayenesiIcinDigerGunler, .tamamlananMemeMuayenesi:
            hideBackgrounds()
            setImage(imageName: type)

        case .none:
            hideBackgrounds(true, true)
        default:
            hideBackgrounds(false, true)
            setImage(imageName: type, true)
        }
    }
    
    func addBottomSemptom() {
        
    }
    
}

extension TriwiCell {
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

//extension UIView {
//}
//
////extension UIView {
////    func addDashedBorder(color: UIColor = UIColor.red, lineWidth: CGFloat = 2) {
////        let shapeLayer:CAShapeLayer = CAShapeLayer()
////        let frameSize = self.frame.size
////        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
////
////        shapeLayer.bounds = shapeRect
////        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
////        shapeLayer.fillColor = UIColor.clear.cgColor
////        shapeLayer.strokeColor = color.cgColor
////        shapeLayer.lineWidth = lineWidth
////        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
////        shapeLayer.lineDashPattern = [6,3]
////        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
////
////        self.layer.addSublayer(shapeLayer)
////    }
////}
//
//enum viewBorder: String {
//    case Left = "borderLeft"
//    case Right = "borderRight"
//    case Top = "borderTop"
//    case Bottom = "borderBottom"
//}
//
//extension UIView {
//
//    func addBorder(vBorder: viewBorder, color: UIColor, width: CGFloat) {
//        let border = CALayer()
//        border.backgroundColor = color.cgColor
//        border.name = vBorder.rawValue
//        switch vBorder {
//            case .Left:
//                border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
//            case .Right:
//                border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
//            case .Top:
//                border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
//            case .Bottom:
//                border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
//        }
//        self.layer.addSublayer(border)
//    }
//
//    func removeBorder(border: viewBorder) {
//        var layerForRemove: CALayer?
//        for layer in self.layer.sublayers! {
//            if layer.name == border.rawValue {
//                layerForRemove = layer
//            }
//        }
//        if let layer = layerForRemove {
//            layer.removeFromSuperlayer()
//        }
//    }
//
//}

//        backView.bounds = self.bounds
//        backView.bounds.insetBy(dx: 3, dy: 0)
//        centerView.frame.size.width = self.bounds.height - 10
//        centerView.frame.size.height = self.bounds.height - 10
//        centerWidth.constant = self.bounds.height


//    func addTopBorder(selectedView: UIView, with color: UIColor?, andWidth borderWidth: CGFloat) {
//        let border = UIView()
//        border.backgroundColor = color
//        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
//        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
//        selectedView.addSubview(border)
//    }
//
//    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
//        let border = UIView()
//        border.backgroundColor = color
//        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
//        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
//        addSubview(border)
//    }
//
//    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
//        let border = UIView()
//        border.backgroundColor = color
//        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
//        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
//        addSubview(border)
//    }
//
//    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
//        let border = UIView()
//        border.backgroundColor = color
//        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
//        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
//        addSubview(border)
//    }



//    func addDashedBorder(viewSelected: UIView, color: UIColor = UIColor.red, lineWidth: CGFloat = 2) {
//        viewSelected.layer.cornerRadius = viewSelected.bounds.width / 2
//        let shapeLayer:CAShapeLayer = CAShapeLayer()
//        let frameSize = viewSelected.frame.size
//        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
//
//
//        shapeLayer.bounds = shapeRect
//        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.strokeColor = color.cgColor
//        shapeLayer.lineWidth = lineWidth
////        shapeLayer.lineDashPattern = [1,2]
//        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
//        shapeLayer.lineDashPattern = [6,3]
//        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: viewSelected.bounds.width / 2).cgPath
//
//        viewSelected.layer.addSublayer(shapeLayer)
////        viewSelected.layoutIfNeeded()
//    }

//    func addDashedMultiBorder(viewSelected: UIView, color: UIColor = UIColor.red, lineWidth: CGFloat = 2) {
//        viewSelected.layer.cornerRadius = viewSelected.bounds.width / 2
//        let shapeLayer:CAShapeLayer = CAShapeLayer()
//        let frameSize = viewSelected.frame.size
//        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
//        shapeLayer.bounds = shapeRect
//        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.strokeColor = color.cgColor
//        shapeLayer.lineWidth = lineWidth
//        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
//        shapeLayer.lineDashPattern = [6,3]
//        shapeLayer.path = UIBezierPath(roundedRect: viewSelected.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: viewSelected.frame.width / 2, height: viewSelected.frame.width / 2)).cgPath
//
//        viewSelected.layer.addSublayer(shapeLayer)
//    }
//
//    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        shapeLayer.mask = mask
//    }
//
//    private func addBorderColor(_ color: UIColor = .clear, _ width: CGFloat = 0, _ borders: UIRectCorner = [.allCorners]) {
//        shapeLayer.cornerRadius = shapeLayer.bounds.width / 2
//        shapeLayer.masksToBounds = true
//        shapeLayer.borderColor = color.cgColor
//        shapeLayer.borderWidth = width
//    }
//
//    private func onlySelectedCorners(_ color: UIColor = .clear, _ width: CGFloat = 0, _ borders: UIRectCorner = [.allCorners]) {
//        shapeLayer.path = UIBezierPath(roundedRect: shapeLayer.bounds, byRoundingCorners: borders, cornerRadii: CGSize(width: shapeLayer.bounds.width / 2, height: shapeLayer.bounds.width / 2)).cgPath
//    }
