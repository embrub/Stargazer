import SwiftUI
import Charts

struct AltitudeChart: View {
    let allData: [AltitudeData]
    let visibleObjects: Set<String>

    var body: some View {
        Chart {
            ForEach(groupedData.keys.sorted(), id: \.self) { objectName in
                if visibleObjects.contains(objectName), let values = groupedData[objectName] {
                    ForEach(values, id: \.hour) { point in
                        LineMark(
                            x: .value("Hour", point.hour),
                            y: .value("Altitude", point.altitude)
                        )
                        .foregroundStyle(by: .value("Object", objectName))
                        .symbol(by: .value("Object", objectName))
                    }
                }
            }
        }
        .chartXAxis { AxisMarks() }
        .chartYAxis { AxisMarks() }
        .frame(height: 350)
        .padding()
    }

    private var groupedData: [String: [AltitudeData]] {
        Dictionary(grouping: allData, by: { $0.object })
    }
}
