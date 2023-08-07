//
//  SessionViewController.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 15/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import UIKit
import FSCalendar
import Kingfisher
import CoreData

class SessionViewController: BaseViewController , FSCalendarDelegate{
    
//    let onlineData = OnlineData()
//
    
    
    let imageArray: [UIImage] = [
        UIImage(named: "Group 117")!,
        UIImage(named: "Group 117")!,
        UIImage(named: "Group 117")!,
        UIImage(named: "Group 117")!
    ]
    
    
    
    lazy var viewModel: SessionViewModel = {
        let obj = SessionViewModel(userService: UserService())
        self.baseVwModel = obj
        return obj
    }()
    var isMainViewVisible = true
    var isCalenderVisible = true
    
    var currentDayCalenderScope:FSCalendarScope = .week
    var currentWeekCalenderScope:FSCalendarScope = .week
    var currentMonthCalenderScope:FSCalendarScope = .month
    var selectedViewType: ViewType = .list
    var categories: [CategoryDatum] = []
    
    var currentCalenderScope: FSCalendarScope = .week
    
    var selectedDate = Date()
    var selectedSegmentIndex: Int = 0
    
    @IBOutlet weak var sessionTableView: UITableView!
    
    
    enum ViewType {
        case calender
        case list
    }
    
    
    var mentorid: String = AppInstance.shared.user_Id ?? ""
    var page: Int = 1
    var filter: String = ""
    var sessionType: String = "online"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerCells()
        setupTableheader()
        // setupClosures()
        CalenderTableCellRegister()
        
        fetchSessionData()
        NotificationCenter.default.addObserver(self, selector: #selector(dataUpdated), name: Notification.Name("DataUpdated"), object: nil)
        
        setHeaderHeight(headerHeight: 165)
        
        if let sessionHeader = sessionTableView.tableHeaderView as? SessionHeader {
            sessionHeader.calenderView.isHidden = true
            sessionHeader.mainView.isHidden = true
            
//            isCalenderVisible = false
//            isMainViewVisible = false

        }
        
        
        viewModel.SessionApi(mentorid: mentorid, page: page, filter: filter, sessionType: sessionType)
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSessionData()
        
//        if isInternetReachable() {
//               // Call the function to fetch and print the online data
//            let fetchedData: () = addOnlineData(careerConsultationlabel: "careerConsultationData", sessionLabel: "aliquaData", aliquaLabel: "economicsData", economicsNatureLabel: "sessionStartedData")
//               // You can use the fetchedData array to populate your UI or perform other operations as needed
//           } else {
//               // Call the function to fetch and print the offline data
//               let fetchedOfflineData = fetchOfflineData()
//               // You can use the fetchedOfflineData array to populate your UI or perform other operations as needed
//           }
    }
    
    func fetchSessionData() {
        viewModel.SessionApi(mentorid: mentorid, page: page, filter: filter, sessionType: sessionType)
        sessionTableView.reloadData()
    }
    
    @objc private func dataUpdated() {
        sessionTableView.reloadData()
    }
    
    
    func addOnlineData(careerConsultationlabel: String, sessionLabel: String, aliquaLabel: String, economicsNatureLabel: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let onlineEntity = NSEntityDescription.entity(forEntityName: "OnlineData", in: managedContext)!

        let onlineObject = NSManagedObject(entity: onlineEntity, insertInto: managedContext)
        onlineObject.setValue(careerConsultationlabel, forKey: "careerConsultationData")
        onlineObject.setValue(sessionLabel, forKey: "aliquaData")
        onlineObject.setValue(aliquaLabel, forKey: "economicsData")
        onlineObject.setValue(economicsNatureLabel, forKey: "sessionStartedData")

        do {
            try managedContext.save()
            print("Data saved successfully")

            // Perform the fetch request after saving the data
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "OnlineData")
            do {
                let fetchedData = try managedContext.fetch(fetchRequest) as! [NSManagedObject]

                // Now you have the fetched data, you can process it as needed
                for data in fetchedData {
                    if let careerConsultationData = data.value(forKey: "careerConsultationData") as? String {
                        print("Career Consultation Data: \(careerConsultationData)")
                    }
                    if let sessionLabel = data.value(forKey: "aliquaData") as? String {
                        print("Session Label: \(sessionLabel)")
                    }
                    if let economicsData = data.value(forKey: "economicsData") as? String {
                        print("Economics Data: \(economicsData)")
                    }
                    if let sessionStartedData = data.value(forKey: "sessionStartedData") as? String {
                        print("Session Started Data: \(sessionStartedData)")
                    }
                }
            } catch let error as NSError {
                print("Fetch request failed with error: \(error.localizedDescription)")
            }

        } catch let error as NSError {
            print("Failed to save", error.localizedDescription)
        }
    }

   

    func fetchOfflineData() -> [OnlineData]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<OnlineData>(entityName: "OnlineData")

        do {
            let fetchedData = try managedContext.fetch(fetchRequest)
            return fetchedData
        } catch let error as NSError {
            print("Fetch request failed with error: \(error.localizedDescription)")
            return nil
        }
    }


    
   

    
    
    func setupTableheader() {
        
        let header = (Bundle.main.loadNibNamed("SessionHeader", owner: self, options: nil)![0] as? UIView)
        sessionTableView.tableHeaderView = header
        
        //  header?.frame =  CGRect(x: 0, y: 0, width: sessionTableView.frame.size.width, height: 200)
        
        if let SessionHeader = header as? SessionHeader{
            
            SessionHeader.segmentControl.addTarget(self, action: #selector(segmentControl), for: .touchUpInside)
            
            SessionHeader.calenderButton2.addTarget(self, action: #selector(CalenderButton2), for: .touchUpInside)
            
            SessionHeader.listButton.addTarget(self, action: #selector(ListButtonPressed), for: .touchUpInside)
            
            SessionHeader.dayweekmonthSegmentControl.addTarget(self, action: #selector(dayWiseSegment), for: .valueChanged)
            
            SessionHeader.todayUpcomingSegmentControl.addTarget(self, action: #selector(todaySegmentPressed), for: .valueChanged)
            
            SessionHeader.leftArrowButton.addTarget(self, action: #selector (leftButtonPressed), for: .touchUpInside)
            
            SessionHeader.rightArrowButton.addTarget(self, action: #selector (rightButtonPressed), for: .touchUpInside)
        }
    }
    
    @objc func rightButtonPressed(_sender:UIButton) {
        switch currentCalenderScope {
                case .week:
                    currentCalenderScope = .month
                case .month:
                    currentCalenderScope = .week
                default:
                    break
                }
                updateCalendarScope()
            
        print("button is working")
    }
    
    @objc func leftButtonPressed(_ sender: UIButton) {
        switch currentCalenderScope {
        case .week:
            // Go back one day in the calendar
            if let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) {
                selectedDate = previousDay
            }
        case .month:
            // Go back one week in the calendar
            if let previousWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: selectedDate) {
                selectedDate = previousWeek
            }
        default:
            // No action needed for .day, as it will remain at .day
            break
        }

        updateCalendarScope()
        print("button is working")
    }

       
  
    func updateCalendarScope() {
            if let sessionHeader = sessionTableView.tableHeaderView as? SessionHeader {
                sessionHeader.calenderView.setScope(currentCalenderScope, animated: false)
            }
        }
    
    @objc func dayWiseSegment(_sender: UISegmentedControl) {
        if let sessionheader = self.sessionTableView.tableHeaderView as? SessionHeader {
            let segmentSelectedindex = sessionheader.dayweekmonthSegmentControl.selectedSegmentIndex
            selectedSegmentIndex = segmentSelectedindex // Store the selected segment index

            switch segmentSelectedindex {
            case 0:
                sessionheader.calenderView.setScope(.week, animated: false)
                currentDayCalenderScope = .week
                print("day")
            case 1:
                sessionheader.calenderView.setScope(.week, animated: false)
                currentWeekCalenderScope = .week
                print("week")
            case 2:
                sessionheader.calenderView.setScope(.month, animated: false)
                currentMonthCalenderScope = .month
                print("month")
            default:
                break
            }

            sessionheader.dayweekmonthSegmentControl.updateUnderlinePosition()
        }
    }

    

    @objc func todaySegmentPressed(_sender: UISegmentedControl) {
        if let sessionheader = self.sessionTableView.tableHeaderView as? SessionHeader {
            let segmentSelectedIndex = sessionheader.todayUpcomingSegmentControl.selectedSegmentIndex
            selectedSegmentIndex = segmentSelectedIndex // Store the selected segment index

            // Perform any actions based on the selected segment index (if needed)
            switch segmentSelectedIndex {
            case 0:
                print("present")
            case 1:
                print("upcoming")
            case 2:
                print("past")
            case 3:
                print("rejected")
            default:
                break
            }

            sessionheader.todayUpcomingSegmentControl.updateUnderlinePosition()
        }
    }


    
    func setHeaderHeight(headerHeight: CGFloat){
        sessionTableView.tableHeaderView?.frame.size.height = headerHeight
    }
    
    @objc func ListButtonPressed(_sender:UIButton) {
        
        
        if let sessionHeader = sessionTableView.tableHeaderView as? SessionHeader {
            sessionHeader.calenderView.isHidden = true
            sessionHeader.mainView.isHidden = true
            
            setHeaderHeight(headerHeight: 165)
            //   let listHeaderViewHeight : CGFloat = 160
            
            //  sessionTableView.tableHeaderView?.frame.size.height = listHeaderViewHeight
            
            sessionTableView.reloadData()
        }
        
        selectedViewType = .list
        sessionTableView.reloadData()
        
    }
    
    

    @objc func CalenderButton2(_sender:UIButton) {



        if let sessionHeader = sessionTableView.tableHeaderView as? SessionHeader {
            isMainViewVisible = !isMainViewVisible
            sessionHeader.calenderView.isHidden = false
            sessionHeader.mainView.isHidden = false

            // Toggle the arrow buttons' enabled state
            sessionHeader.leftArrowButton.isEnabled = isMainViewVisible
            sessionHeader.rightArrowButton.isEnabled = isMainViewVisible


            let calenderHeaderViewHeight: CGFloat = 554
            setHeaderHeight(headerHeight:calenderHeaderViewHeight)


            // Toggle the arrow buttons' enabled state
            sessionHeader.leftArrowButton.isEnabled = isMainViewVisible
            sessionHeader.rightArrowButton.isEnabled = isMainViewVisible


            //   sessionTableView.tableHeaderView?.frame.size.height = calenderHeaderViewHeight
            sessionTableView.reloadData()
        }
        sessionTableView.reloadData()
        selectedViewType = .calender
        print("button is working")
    }
    
    @objc func segmentControl() {
        print("button is pressed")
        
    }
    
    
    func setupTableView() {
        sessionTableView.delegate = self
        sessionTableView.dataSource = self
        sessionTableView.register(UINib(nibName: "SessionTableViewCell", bundle: nil), forCellReuseIdentifier: "SessionTableViewCell")
    }
    func CalenderTableCellRegister()
    {
        sessionTableView.register(UINib(nibName:"UpcomingTableViewCell" , bundle: nil), forCellReuseIdentifier: "UpcomingTableViewCell")
        sessionTableView.reloadData()
    }
    
    func registerCells()
    {
        sessionTableView.register(UINib(nibName:"SessionTableViewCell" , bundle: nil), forCellReuseIdentifier: "SessionTableViewcell")
        sessionTableView.reloadData()
    }
    
}

    extension SessionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getSessionData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch selectedViewType {
            
        case .list :
            let cell = tableView.dequeueReusableCell(withIdentifier: "SessionTableViewCell", for: indexPath) as! SessionTableViewCell
            let session = viewModel.getSessionData()[indexPath.row]
            if let data = AppInstance.shared.SessionFile?.data?.docs?[indexPath.row]{
                if let imageUrlString = data.category_data?.first?.image{
                    let imageFull:String = Config.BASE_URL + imageUrlString
                    if let imageURL = URL(string:imageFull){
                        cell.setImage(from: imageURL)
                        print(imageURL)
                    }else {
                        cell.SessionImage.image = UIImage(named: " Group 92")
                    }
                    print(imageFull)
                }
                
            }
            
            // Update the labels and image view in the cell with the fetched data
            let careerConsultationlabel:String = session.time!
            let sessionLabel:String = session.session_name!
            let aliquaLabel:String = session.location!
            let economicsNatureLabel:String = session.description!
            
            //let AmetminimLabel.String = session.time!
            
            
            cell.careerConsultationlabel.text = careerConsultationlabel
            cell.sessionLabel.text = sessionLabel
            cell.aliquaLabel.text = aliquaLabel
            cell.economicsNatureLabel.text = economicsNatureLabel
          //   cell.SessionImage.image = UIImage(named: CategoryDatum.) // Replace 'imageName' with the property that contains the image name or image data in 'SessionFile'
            
                        addOnlineData(careerConsultationlabel: careerConsultationlabel, sessionLabel: sessionLabel, aliquaLabel: aliquaLabel, economicsNatureLabel: economicsNatureLabel)
                       // print(careerConsultationlabel)
            
            return cell
            
        case .calender :
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell", for: indexPath) as! UpcomingTableViewCell
            let session = viewModel.getSessionData()[indexPath.row]
            cell.upcomingImageView.image = imageArray[indexPath.row]
            cell.careerConsultationLabel.text = session.time
            cell.economicsLabel.text = session.description
            cell.aliquaLabel.text = session.id
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch selectedViewType {
            
        case .list:
            return 300.0
        case  .calender:
            return 110
        }
    }
}

extension SessionViewController {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
        view.layoutIfNeeded()
    }
}

extension UISegmentedControl {
    func updateUnderlinePosition() {
        removeUnderline() // Remove any existing underline

        let underlineHeight: CGFloat = 1 // Adjust the height of the underline as needed
        let underlineView = UIView(frame: CGRect(x: 0, y: bounds.height - underlineHeight, width: bounds.width / CGFloat(numberOfSegments), height: underlineHeight))
        underlineView.backgroundColor = UIColor.black
        underlineView.tag = 999
        addSubview(underlineView)

        let segmentWidth = bounds.width / CGFloat(numberOfSegments)
        let underlineX = segmentWidth * CGFloat(selectedSegmentIndex)
        underlineView.frame.origin.x = underlineX
    }

    func removeUnderline() {
        for subview in subviews {
            if subview.tag == 999 {
                subview.removeFromSuperview()
            }
        }
    }
}
