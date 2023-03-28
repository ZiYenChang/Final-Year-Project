//
//  LowMoodView.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/03/2023.
//

import SwiftUI

struct LowMoodView: View {
    @State private var answerHasSelected: Bool = false
    @State private var selection: Int = 7
    
    var body: some View {
        
        VStack {
            if !answerHasSelected{
                Text("You seems to be not satisfied with your current progress. What is bothering you?🤔")
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    answerHasSelected = true
                    selection = 1
                }, label: {
                    Text("Deadline / Multiple deadlines coming up soon and I am anxious about it 🗓️")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                    
                })
                .buttonStyle(.bordered)
                
                Button(action: {
                    answerHasSelected.toggle()
                    selection = 2
                }, label: {
                    Text("My tasks are not progressing as expected 😥")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                    
                })
                .buttonStyle(.bordered)
                
                Button(action: {
                    answerHasSelected.toggle()
                    selection = 3
                }, label: {
                    Text("It seems hard to manage and I feel overwhelmed. I can't see my progress much 🧐")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                    
                })
                .buttonStyle(.bordered)
                
                Button(action: {
                    answerHasSelected.toggle()
                    selection = 4
                }, label: {
                    Text("There are other distractions that cause me to procrastinate.🐢")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                    
                })
                .buttonStyle(.bordered)
                
                Button(action: {
                    answerHasSelected.toggle()
                    selection = 5
                }, label: {
                    Text("I find the task difficult and I don't fully know how to do it 😵‍💫")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                    
                })
                .buttonStyle(.bordered)
                
                Button(action: {
                    answerHasSelected.toggle()
                    selection = 6
                }, label: {
                    Text("I think I need a break 🥱")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                    
                })
                .buttonStyle(.bordered)
                
                Button(action: {
                    answerHasSelected.toggle()
                    selection = 7
                }, label: {
                    Text("I don't feel motivated 😪")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                    
                })
                .buttonStyle(.bordered)
            
            
            }else{
                if selection == 1{
                    Image("cat-liedown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150.0)
                    Text("Multiple looming deadlines can be daunting. Everyone deals with stress differently, so take time to find methods that work for you.")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding(.bottom,3)
                    Text("Have a Look at Jess's suggestion on [10 tips to cope with stressful deadlines](https://www.healthline.com/health/mental-health/impossible-task-anxiety#Ways-to-overcome-the-impossible-task), perhaps you can find a way to cope with your anxiety💛")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                }
                else if selection == 2{
                    Image("rabbit-hug")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150.0)
                    Text("Disappointment is a natural reaction when things don’t go as intended.")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding(.bottom,3)
                    Text("You may find PsychCentral's suggestions on [what to do when things don’t turn out the way you planned](https://psychcentral.com/blog/when-things-dont-turn-out-how-youd-hoped-expected-or-planned) helpful, so have a look on the website!")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                }
                else if selection == 3{
                    Image("fox")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150.0)
                    Text("Breaking down a task into subtasks can help with making a task more manageable and less overwhelming. It might be a good idea to utilised the subtasks feature to breakdown your task! Indeed's suggestion on [How To Break Down Tasks in 5 Step](https://www.indeed.com/career-advice/career-development/how-to-break-down-tasks) might help you with this!💛")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                }
                else if selection == 4{
                    Image("bee")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150.0)
                    Text("Small changes make a big difference. Starting from behavioral practices suggested by Healthline's on [how to stay focused](https://www.healthline.com/health/mental-health/how-to-stay-focused#remove-distractions), perhaps it may help you approach your tasks with greater engagement and attention💛")
                    Text("Queen Mary also offer [advice on procrastination](https://www.qmul.ac.uk/welfare/wellbeing-support/wellbeing-resources/a-z-common-topics/procrastination/), this might be what you need!💛")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                }
                else if selection == 5{
                    Image("fox-jump")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150.0)
                    Text("Don't worry, you are not alone.")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding(.bottom,3)
                    Text("Many students find the their university work difficult too. Perhaps utilise the module forum on [QMPlus](https://qmplus.qmul.ac.uk) to ask for support, or reach out to the module organiser to get advise.")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding(.bottom,3)
                    Text("Besides, find out more about the [academic, research and information skills support](https://www.qmul.ac.uk/library/academic-skills/) available at Queen Mary. The [Revise Well](https://www.qmul.ac.uk/library/old-academic-skills/revise-well/) page also includes a variety of resources to support you in achieving the best you can!")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                }
                else if selection == 6{
                    Image("luggage-weather")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130.0)
                    Text("It may be time to take a step back and slow down when you feel burnout.💛")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding(.bottom,3)
                    Text("NHS suggested [10 stress busters](https://www.nhs.uk/mental-health/self-help/guides-tools-and-activities/tips-to-reduce-stress/) to address and cope with stress, you might find one that suits you!")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding(.bottom,3)
                    Text("If you are struggling with your current situation and need a longer time to complete your coursework, you might want to consider to apply for [extenuating circumstances](https://www.qmul.ac.uk/student-experience/student-wellbeing-hub/extenuating-circumstances-a-guide-for-students/).")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                }
                else if selection == 7{
                    Image("hug-smile")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 130.0)
                    Text("There will be days where you're not motivated, but this is totally fine.")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding(.bottom,3)
                    Text("It's important to step out of your comfort zone. Queen Mary Residential list down [5 ways to increase your motivation](https://residentiallife.qmul.ac.uk/5-ways-to-increase-your-motivation_132343), you might find this helpful!💛")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding(.bottom,3)
                    Text("If you need external help, try reaching out to get Queen Mary's [emotional and mental wellbeing support](https://www.qmul.ac.uk/welfare/wellbeing-support/) so you feel able to engage and enjoy your studies!")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                }
                
                Button("Back", role: .cancel) {
                    answerHasSelected.toggle()
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4.5, x: 0, y: 0)
        .animation(.easeInOut, value: answerHasSelected)
        
    }
}

struct LowMoodView_Previews: PreviewProvider {
    static var previews: some View {
        LowMoodView()
    }
}
