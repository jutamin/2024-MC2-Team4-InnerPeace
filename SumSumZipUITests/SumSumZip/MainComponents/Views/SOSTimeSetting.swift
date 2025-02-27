//
//  SOSTimeSetting.swift
//  SumSumZip
//
//  Created by Dongin Kang on 5/20/24.
//

import SwiftUI

struct SOSTimeSetting: View {
//    @State private var selectedTime: Int = 30
    // selectedTime 이름을 waitingTime으로 바꾸었습니다.
    @Binding var waitingTime: Int
    @Environment(\.dismiss) var dismiss

    
    let times = [10, 20, 30, 40, 50]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Divider() // 얇은 선 추가
                    .background(Color.white)
                VStack {
                    headerView
                        .padding(.vertical, 30)
                        .padding(.horizontal, 15)
                    selectedTimeView
                        .padding(.vertical, 30)
                    timeSelectionCircles
                        .padding(.vertical, 50)
                    Spacer()
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("구조 타이밍 설정")
                            .fontWeight(.bold)
                            .font(.headline)
                            .foregroundColor(AppColors.darkGreen)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack(spacing: 0){
                            Button(action: {
                                let SOSsavedTime = SOSTimeDataManager.shared.fetchTime()
                                waitingTime = SOSsavedTime != 0 ? SOSsavedTime : 30
                                dismiss()
                            }) {
                                Text("취소")
                                    .foregroundColor(AppColors.darkGreen)
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            SOSTimeDataManager.shared.saveTime(waitingTime)
                            dismiss()
                        }) {
                            Text("저장")
                                .foregroundColor(AppColors.darkGreen)
                        }
                    }
                }
                
            }
        }
        .navigationBarBackButtonHidden ()
        .onAppear(){
            let SOSsavedTime = SOSTimeDataManager.shared.fetchTime()
            waitingTime = SOSsavedTime != 0 ? SOSsavedTime : 30
            // 저장된 값이 있으면 그 값을 waitingTime(selectedTime)에 저장하고, 그렇지 않으면 기본값인 30을 사용합니다.
        }
    }
    
    var headerView: some View {
        VStack(alignment: .leading){
            HStack {
                Text("구조 타이밍 설정")
                    //.font(.headline)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                Spacer() // 왼쪽 정렬 유지
            }
            Text("도와주세요 버튼 클릭 시, 설정한 구조타이밍 시간 이후에\nSOS 알람이 활성화됩니다.")
                .font(.caption)
                .foregroundStyle(AppColors.systemGray)
        }
    }
    
    var selectedTimeView: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Text("\(Int(waitingTime))")
                .font(.system(size: 37, weight: .bold))
                .foregroundColor(AppColors.darkGreen)
            Text("초")
                .font(.system(size: 17))
                .foregroundColor(AppColors.darkGreen)
                .baselineOffset(5)
        }
    }
    
    var timeSelectionCircles: some View {
         VStack {
             ZStack {
                 // 중앙 줄
                 Rectangle()
                     .fill(AppColors.darkGreen)
                     .frame(height: 1)
                     .offset(y: -21) // 원의 중앙을 관통하도록 위치 조정
                     .padding(.horizontal, 43) // 줄의 길이를 줄이기 위해 수평 패딩 추가
                 
                 //원들
                 HStack(spacing: 40) {
                     ForEach(times, id: \.self) { time in
                         VStack {
                             Circle()
                                 .fill(time == waitingTime ? AppColors.black : AppColors.darkGreen) // 선택된 시간일 때는 검은색, 그렇지 않을 때는 어두운 녹색으로 채웁니다.
                                 .frame(width: 17, height: 17) // 원의 크기를 설정합니다.
                                 .scaleEffect(time == waitingTime ? 2.0 : 1.0) // 선택된 원의 크기를 두 배로 확대합니다.
                                 .animation(.easeInOut, value: waitingTime) // 선택된 시간이 변경될 때 애니메이션 효과를 적용합니다.
                                 .overlay(
                                    Circle()
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    AppColors.lightCyan, AppColors.lightBlue]), // 그라데이션 색상 배열을 설정합니다.
                                                startPoint: .topLeading, // 그라데이션의 시작 지점을 설정합니다.
                                                endPoint: .bottomTrailing // 그라데이션의 끝 지점을 설정합니다.
                                            ),
                                            lineWidth: 3 // 테두리 두께를 설정합니다.
                                        )
                                        .scaleEffect(time == waitingTime ? 2.0 : 0) // 선택된 원의 테두리를 두 배로 확대합니다.
                                )
                                 .onTapGesture {
                                     withAnimation {
                                         waitingTime = time // 원을 탭하면 선택된 시간을 해당 시간으로 변경합니다.
                                     }
                                 }

                             Spacer().frame(height: 21)
                             Text("\(time)초")
                                 .foregroundColor(AppColors.darkGreen)
                         }
                     }
                 }
             }
         }
     }
 }


//#Preview {
//    SOSTimeSetting()
//}

struct SOSTimeSetting_Previews: PreviewProvider {
    @State static var waitingTime: Int = 30

    static var previews: some View {
        SOSTimeSetting(waitingTime: $waitingTime)
    }
}
