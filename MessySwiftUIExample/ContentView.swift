//
// Created in 2022
// Using Swift 5.0
// On 30.07.2022 by Alex Dremov
// 
//

import SwiftUI
import PathPresenter

struct ContentView: View {
    @State var path = PathPresenter.Path()
    
    var body: some View {
        PathPresenter.RoutingView(path: $path)
            .onAppear{
                let data = [
                    (text: "Nice", subtext: "Onborading sequence of screens"),
                    (text: "OK", subtext: "But how to do it with SwiftUI?"),
                    (text: "So that", subtext: "it is nice and shiny")
                ]
                
                let typeCommon: PathPresenter.PathType =
                    .animated(
                        transition: .asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)),
                        animation: .easeInOut
                    )

                path.append(
                    data: data,
                    type: typeCommon
                ) { (text, subtext) in
                    boldText(
                        text: text,
                        subtext: subtext
                    )
                }
                
                path.append(boldText(
                    text: "And also",
                    subtext: "flexible enough to cover all your needs"
                ), type: .sheet(onDismiss: {}))
                
                path.append(boldText(
                    text: "Read the post",
                    subtext: "to find the solution"
                ), type: typeCommon)
                
                path.reverse()
            }
    }
    
    @ViewBuilder
    func boldText(text: String, subtext: String) -> some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Text(text)
                    .font(.system(size: 65))
                .fontWeight(.bold)
                Spacer()
            }
            Text(subtext)
                .foregroundColor(.gray)
                .font(.system(size: 26))
            Button(action: {
                path.removeLast()
            }){
                Text("NEXT")
                    .font(.system(size: 18))
                    .padding(.vertical, 5)
                    .padding(.horizontal, 24)
                    .foregroundColor(.gray)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.gray, lineWidth: 2)
                        )
            }
            .padding(.top, 30)
            Spacer()
        }
        .padding(20)
        .padding(.leading, 50)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
