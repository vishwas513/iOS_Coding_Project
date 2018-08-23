//
//  DashboardViewController.swift
//  Clerkie_iOS_Challenge
//
//  Created by Vishwas Mukund on 8/21/18.
//  Copyright © 2018 Vishwas Mukund. All rights reserved.
//

import Foundation
import UIKit
import Charts

class DashboardViewController : UIViewController {
    
    @IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var horizontalBarChart: HorizontalBarChartView!
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBAction func segment(_ sender: Any) {
        let selection = segment.selectedSegmentIndex;
        if(selection == 0){
           // segment.selectedSegmentIndex = 0;
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil);
            let ChatViewController = storyBoard.instantiateViewController(withIdentifier: "chatViewController") as! UIViewController
            self.present(ChatViewController , animated:true, completion:nil)
            
        }else if(selection == 1){
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil);
            let ChatViewController = storyBoard.instantiateViewController(withIdentifier: "dashboardViewController") as! UIViewController
            self.present(ChatViewController , animated:true, completion:nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        segment.selectedSegmentIndex = 1;
        let entry1 = BarChartDataEntry(x: 1.0, y: Double(10))
        let entry2 = BarChartDataEntry(x: 2.0, y: Double(50))
        let entry3 = BarChartDataEntry(x: 3.0, y: Double(100))
        
        
        
        let dataSet = BarChartDataSet(values: [entry1, entry2, entry3], label: "Widgets Type")
        let data = BarChartData(dataSets: [dataSet])
        barChart.data = data
        barChart.chartDescription?.text = "Number of Widgets by Type"
        
        horizontalBarChart.data = data;
        horizontalBarChart.chartDescription?.text = "Number of Widgests"
        //All other additions to this function will go here
        
        //This must stay at end of function
        barChart.notifyDataSetChanged()
        horizontalBarChart.notifyDataSetChanged()
        
    }

    
}
