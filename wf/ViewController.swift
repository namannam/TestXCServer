

import UIKit

class ViewController: UIViewController, UITableViewDelegate , UITableViewDataSource{
    var btnMakeChanges = UIButton()

    var vm : CPDDConfirmViewModel? = nil
    @IBOutlet weak var tableV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let widthTable = self.tableV?.frame.width {
            btnMakeChanges.frame = CGRect(x: 0, y: 0, width: widthTable, height: 50)
        }
        // Do any additional setup after loading the view, typically from a nib.
         vm = CPDDConfirmViewModel(data: "FFFFFFF")
        
        tableV.dataSource = self
        tableV.delegate = self

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return vm!.items.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 1 && indexPath.row == 0
        {
            let btnCell =  UITableViewCell(style: .default, reuseIdentifier: "cellMakeChangesButton")
        btnMakeChanges.isUserInteractionEnabled = false
        btnMakeChanges.layer.cornerRadius = 0.5
        btnMakeChanges.setTitle("Accept", for: .normal)
        btnMakeChanges.setTitleColor(UIColor.white, for: .normal)
        if let tab = self.tableV {
            btnMakeChanges.frame = CGRect(x: 0, y: 0, width: tab.frame.width, height: 50)
        }
        btnMakeChanges.titleLabel?.font = UIFont(name: "Interstate-Regular", size: 16)
        btnMakeChanges.backgroundColor =  UIColor.green
        btnCell.addSubview(btnMakeChanges)
        btnCell.selectionStyle = .none
        btnCell.separatorInset = UIEdgeInsetsMake(0, CGFloat.greatestFiniteMagnitude, 0, 15)
        
        return btnCell
        }
        
        
        switch vm?.items[indexPath.row].type {
        case .checkImage?:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "a")
            cell.textLabel?.text = "Check "
            return cell
        case .headetText?:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "a")
            cell.textLabel?.text = "Header "
             return cell
        case .paymentCell?:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "a")
            if let a = vm?.items[indexPath.row] as? VMItemsPaymentLabel{
                cell.textLabel?.text = a.labelTextHdrDesc
            }
            
             return cell
        default:
            break
        }
        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}














enum CPDDCellTypes{
    case checkImage
    case headetText
    case paymentCell
}

protocol CPDDCellStructureDesign {
    var type : CPDDCellTypes {get}
    var rowCount: Int {get}
}

extension CPDDCellStructureDesign{
    var rowCount : Int {
        return 1
    }
}


class VMItemsCheck : CPDDCellStructureDesign{
    var type: CPDDCellTypes{
        return .checkImage
    }
}


class VMItemsHeader : CPDDCellStructureDesign{
    var type: CPDDCellTypes{
        return .headetText
    }

}

class VMItemsPaymentLabel : CPDDCellStructureDesign{
    var type: CPDDCellTypes{
        return .paymentCell
    }
    var labelTextHdr : String
    var labelTextHdrDesc : String
    init(labelTextHdr:String , labelTextHdrDesc: String) {
        self.labelTextHdr = labelTextHdr
        self.labelTextHdrDesc = labelTextHdrDesc
    }
}





class CPDDConfirmViewModel {
    var items = [CPDDCellStructureDesign]()
    init(data:String) {
        let one = VMItemsCheck()
        items.append(one)
        
        let two = VMItemsHeader()
        items.append(two)
        
        let three = VMItemsPaymentLabel(labelTextHdr: data, labelTextHdrDesc: "abcd")
        items.append(three)
        
        let four = VMItemsPaymentLabel(labelTextHdr: "yoyo", labelTextHdrDesc: data)
        items.append(four)
        
        let five = VMItemsHeader()
        items.append(five)

    }
}

