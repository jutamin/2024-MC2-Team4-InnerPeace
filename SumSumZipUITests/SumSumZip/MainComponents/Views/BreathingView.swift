//
//  BreathingView.swift
//  SumSumZip
//
//  Created by 원주연 on 5/20/24.
//

//import SwiftUI
//
//struct BreathingView: View {
//    @Binding var isAnimating: Bool
//    @Binding var isShownSheet: Bool
//    @Binding var isShownContact: Bool
//    @State private var showingAlert: Bool = false
//    
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    @State private var count: Int = 1
//    @State private var finishedText: String? = nil
//    @State private var timeRemaining = ""
//    let futureData: Date = Calendar.current.date(byAdding: .minute, value: 30, to: Date()) ?? Date()
//    
//    func updateTimeRemaining() {
//        let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureData)
//        let minute = remaining.minute ?? 0
//        let second = remaining.second ?? 0
//        timeRemaining = "\(minute) : \(second)"
//    }
//    
//    let workoutDateRange = Date()...Date().addingTimeInterval(30*60)
//    
//    var body: some View {
//        NavigationView{
//            ZStack{
//                LinearGradient(gradient: Gradient(colors: [Color.black, AppColors.lightSage, AppColors.lightGreen]),
//                               startPoint: .top, endPoint: .bottom)
//                            .edgesIgnoringSafeArea(.all)
//                VStack{
//                    Spacer().frame(height: 100)
//                    Text("도움이 필요합니다")
//                        .foregroundStyle(Color.white)
//                        .font(.largeTitle)
//                        .fontWeight(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
//                        .padding(.bottom, 7)
//                    Text("일시적인 공황 증상 발생")
//                        .foregroundStyle(Color.white)
//                        .font(.title2)
//                    Spacer().frame(height: 70)
//                    Text(isAnimating ? "내쉬고" : "들이마시고")
//                        .foregroundStyle(Color.primary)
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .animation(.easeOut(duration: 4).delay(1).repeatForever(), value: isAnimating)
//                    ZStack{
//                        Circle()
//                            .foregroundStyle(Gradient(colors: [Color("PointColor2"), Color.white]))
//                            .shadow(radius: 10)
//                            .shadow(color: .white, radius: 40)
//                            .padding(.horizontal, 20)
//                            .scaleEffect(isAnimating ? 0.7 : 1.2)
//                            .animation(.easeOut(duration: 4).delay(1).repeatForever(),
//                                       value: isAnimating)
//                        
//                        Circle()
//                            .frame(width: 200, height: 200)
//                        GifImageViewer("BreathingFace")
//                            .frame(width: 200, height: 200)
//                            .cornerRadius(100)
//                    }
//                    .onAppear(perform: {
//                        isAnimating.toggle()
//                    })
//                    
//                    Spacer().frame(height: 20)
//                    
//                    Text(timeRemaining)
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .foregroundColor(.black)
//                        .lineLimit(1)
//                        .minimumScaleFactor(0.1)
//                    
//                    Spacer().frame(height: 30)
//                    Text("만약 제가 의식이 없다면\n긴급연락과 119에 신고해주세요")
//                        .font(.title3)
//                        .multilineTextAlignment(.center)
//                        .foregroundColor(.secondary)
//                    Spacer().frame(height: 20)
//                    ProgressView(timerInterval: workoutDateRange, countsDown: false)
//                        .padding()
//                        .progressViewStyle(LinearProgressViewStyle(tint: .white))
//                    Spacer().frame(height: 30)
//
//                }
//            }
//            .toolbar{
//                Button("상황종료"){
//                    print("상황종료")
//                    showingAlert = true
//                    isShownSheet = false
// 
//                }
//                .foregroundStyle(AppColors.lightSage)
//                .alert(isPresented: $showingAlert){
//                    Alert(title: Text("도와주셔서 감사합니다."), message: Text("당신은 영웅입니다."),
//                                      dismissButton: .default(Text("상황종료")))
//                }
//            }
//            .toolbar{
//                ToolbarItemGroup(placement: .bottomBar){
//                    Button("환자 정보"){
//                        print("환자 정보")
//                    }
//                    .foregroundStyle(Color.gray)
//                    .font(.title3)
//                    .fontWeight(.bold)
//                    
//                    Button("긴급 연락"){
//                        print("긴급 연락")
//                        isShownContact = true
//                    }
//                    .foregroundStyle(Color.red)
//                    .font(.title3)
//                    .fontWeight(.bold)
//                }
//            }
//            .onAppear {
//                updateTimeRemaining()
//            }
//            .onReceive(timer) { value in
//                withAnimation(.default) {
//                    count = count == 5 ? 1 : count + 1
//                }
//                updateTimeRemaining()
//            }
//            .fullScreenCover(isPresented: $isShownContact, content: {
//                ContactView(isShownContact: $isShownContact)
//            })
//        }
//        .blur(radius: isShownContact ? 5.0 : 0)
//    }
//}
//
////#Preview {
////    SOSView()
////}
