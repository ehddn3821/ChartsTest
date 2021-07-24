//
//  ViewController.swift
//  ChartsTest
//
//  Created by dwKang on 2021/07/24.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    var chartView = BarChartView()
    var months: [String]!
    var unitsSold: [Double]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setUI()
        setChart(dataPoints: months, values: unitsSold)
    }
    
    
    func setUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.backgroundColor = .systemBackground
        chartView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        chartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        chartView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        chartView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        chartView.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
    }

    func setChart(dataPoints: [String], values: [Double]) {
        
        // 데이터 없을 경우
        chartView.noDataText = "데이터가 없습니다."
        chartView.noDataFont = .systemFont(ofSize: 20)
        chartView.noDataTextColor = .lightGray
        
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "판매량")
        
        // 차트 컬러
        chartDataSet.colors = [.systemIndigo]
        
        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        chartView.data = chartData
        
        // x축 레이블 설정
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        chartView.xAxis.setLabelCount(dataPoints.count, force: false)  // 띄엄띄엄 생략 안하게
        
        // 오른쪽 레이블 제거
        chartView.rightAxis.enabled = false
        
        // 애니메이션
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
        // Limit line
        let limitLine = ChartLimitLine(limit: 10.0, label: "Target")
        chartView.leftAxis.addLimitLine(limitLine)
        
        // Max Min
        chartView.leftAxis.axisMaximum = 30
        chartView.leftAxis.axisMinimum = -10
    }
}
