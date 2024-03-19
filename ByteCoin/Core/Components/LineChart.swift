//
//  LineChart.swift
//  ByteCoin
//
//  Created by Muharrem Köroğlu on 27.02.2024.
//

import SwiftUI

struct LineChart: View {
    
    @State private var effectPercentage : CGFloat = 0
    @State private var touchPosition: CGPoint? = nil
    @State private var selectedValue: Double? = nil
    
    private let lineChartData : [Double]
    private let lineColor : Color
    private let maxY : Double
    private let minY : Double
    private let startingDate : Date
    private let endingDate : Date
    
    
    init(coin : AllCoinsDataResponseModel) {
        
        lineChartData = coin.sparklineIn7D?.price ?? []
        
        maxY = lineChartData.max() ?? 0
        minY = lineChartData.min() ?? 0
        
        let priceChange = (lineChartData.last ?? 0) - (lineChartData.first ?? 0)
        lineColor = priceChange > 0 ? .green : priceChange < 0 ? .red : .gray
        
        endingDate = Date(willFormattedDate: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
        
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                let size = geometry.size
                Path { path in
                    for index in lineChartData.indices {
                        
                        let xPosition = size.width / CGFloat(lineChartData.count) * CGFloat(index + 1)
                        let yAxis = maxY - minY
                        let yPosition = (1 - CGFloat((lineChartData[index] - minY) / yAxis)) * size.height
                        
                        if index == 0 {
                            path.move(to: CGPoint(x: xPosition, y: yPosition))
                        }
                        
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }.trim(from: 0,to: effectPercentage)
                    .stroke(lineColor, style: StrokeStyle(lineWidth: 3,lineCap: .round,lineJoin: .round))
                    .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
                    .shadow(color: lineColor.opacity(0.8), radius: 10, x: 0.0, y: 15)
                    .background(
                        ChartBackground()
                    )
                    .overlay(alignment: .leading) {
                        ChartPriceLabels(maxY: maxY, minY: minY)
                            .padding(.horizontal,5)
                        
                    }
                    .gesture(DragGesture()
                        .onChanged { value in
                            touchPosition = value.location
                            updateSelectedValue(value.location, geometry: geometry)
                        }
                        .onEnded { _ in
                            touchPosition = nil
                            selectedValue = nil
                        }
                    )
                    .overlay(
                        touchPosition.map {
                            ChartPriceIndicator(selectedValue: selectedValue ?? 1, x: $0.x, maxY: maxY, minY: minY, size: size)
                        }
                    )
            }
            ChartDateLabels(startDate: startingDate, endDate: endingDate)
                .padding(.vertical, 10)
                .padding(.horizontal,5)
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.linear(duration: 1.5)) {
                    effectPercentage = 1.0
                }
            }
        }
    }
    

    
}

extension LineChart {
    
    private func updateSelectedValue(_ position: CGPoint, geometry: GeometryProxy) {
        let size = geometry.size
        let index = Int((position.x / size.width) * CGFloat(lineChartData.count))
        guard index >= 0 && index < lineChartData.count else {
            return
        }
        selectedValue = lineChartData[index]
    }
}

struct ChartPriceIndicator: View {
    
    let selectedValue: Double
    let x: CGFloat
    let maxY: Double
    let minY: Double
    let size: CGSize
    
    var body: some View {
        GeometryReader { geometry in
            let yPosition = (1 - CGFloat((selectedValue - minY) / (maxY - minY))) * size.height
            Path { path in
                path.move(to: CGPoint(x: x, y: 0))
                path.addLine(to: CGPoint(x: x, y: size.height))
            }
            .stroke(.appMain, style: StrokeStyle(lineWidth: 1))
            .overlay(
                Text("\(selectedValue.convertWithAbbreviations())")
                    .font(.caption)
                    .foregroundStyle(.primary)
                    .padding(4)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .offset(y: yPosition > geometry.size.height - 20 ? -20 : 0)
                    .position(x: x, y: yPosition > geometry.size.height - 20 ? yPosition - 20 : yPosition)
            )
        }
    }
}

struct ChartBackground : View {
    var body: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
}

struct ChartPriceLabels : View {
    
    let maxY : Double
    let minY : Double
    
    var body: some View {
        VStack {
            Text(maxY.convertWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).convertWithAbbreviations())
            Spacer()
            Text(minY.convertWithAbbreviations())
        }.font(.callout)
            .foregroundStyle(.gray)
    }
}

struct ChartDateLabels : View {
    
    let startDate : Date
    let endDate : Date
    
    var body: some View {
        HStack {
            Text(startDate.convertDateToString())
            Spacer()
            Text(endDate.convertDateToString())
        }.font(.caption)
            .foregroundStyle(.gray)
    }
}
