//
//  ContentView.swift
//  Slot Machine
//
//  Created by english on 2024-09-16.
//

import SwiftUI

struct Hexagon: Shape {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
   func path(in rect: CGRect) -> Path {
       // p1 -> p6
       return Path { // callback function
           path in
           // six point of the hexagon
           let p1 = CGPoint(x: 0, y: 20)
           let p2 = CGPoint(x: 0, y: rect.height - 20)
           let p3 = CGPoint(x: rect.width/2, y: rect.height)
           let p4 = CGPoint(x: rect.width, y: rect.height - 20)
           let p5 = CGPoint(x: rect.width, y: 20)
           let p6 = CGPoint(x: rect.width/2, y: 0)
           
           // cursor for our path to move
           path.move(to: p6) // either the first p1 or last p6
           
           // move the cursor
           path.addArc(tangent1End: p1, tangent2End: p2, radius: 15)
           path.addArc(tangent1End: p2, tangent2End: p3, radius: 15)
           path.addArc(tangent1End: p3, tangent2End: p4, radius: 15)
           path.addArc(tangent1End: p4, tangent2End: p5, radius: 15)
           path.addArc(tangent1End: p5, tangent2End: p6, radius: 15)
           path.addArc(tangent1End: p6, tangent2End: p1, radius: 15)

           
       }
   }
}

//enum - used to compare values together
enum Choice: Int, Identifiable{
    //id
    var id: Int{
        rawValue //a raw integer value 0,1,2
    }
    //case
    case success, failure //Identifiable
}


struct ContentView: View {
    
    //variables
    @State public var symbols = ["eating", "happy", "love"]
    @State public var numbers = [0,1,2]
    @State public var counter = 0
    @State private var showingAlert: Choice?  //might come out success or failure
    
    var body: some View {
        ZStack {
            Image("sunshine")
                .resizable()
                .ignoresSafeArea()
        
            VStack(alignment: .center, spacing: 60){
                HStack{
                    //image
                    Image("fire")
                        .resizable()
                        .scaledToFit()
                        .shadow(color: .orange, radius: 1, y:3)
                    
                    //text
                    Text("Slot Machine")
                        .font(.system(size: 25))
                        .fontWeight(.black)
                        .shadow(color: .orange, radius: 1, y:3)
                    
                    //image
                    Image("fire")
                        .resizable()
                        .scaledToFit()
                        .shadow(color: .orange, radius: 1, y:3)
                }
                .frame(height:100, alignment: .center)
                
                VStack(spacing: 15){
                    HStack(spacing: 15){
                        Hexagon()
                            .fill(Color.white.opacity(0.8))
                            .frame(width: 100, height: 120, alignment: .center)
                            .overlay(
                                Image(symbols[numbers[0]])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 70, alignment: .center)
                            )
                        
                        Hexagon()
                            .fill(Color.white.opacity(0.8))
                            .frame(width: 100, height: 120, alignment: .center)
                            .overlay(
                                Image(symbols[numbers[0]])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 70, alignment: .center)
                            )
                    }
                    
                   
                    Hexagon()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: 100, height: 120, alignment: .center)
                        .overlay(
                            Image(symbols[numbers[1]])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70, alignment: .center)
                            )
                      
                    HStack(spacing: 15){
                        Hexagon()
                            .fill(Color.white.opacity(0.8))
                            .frame(width: 100, height: 120, alignment: .center)
                            .overlay(
                                Image(symbols[numbers[2]])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 70, alignment: .center)
                                )
                            
                        Hexagon()
                            .fill(Color.white.opacity(0.8))
                            .frame(width: 100, height: 120, alignment: .center)
                            .overlay(
                                Image(symbols[numbers[2]])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 70, alignment: .center)
                                )
                    }
                    
                        
                }
                
                Button(action: {
                    //only 6 attempts are allowed
                    self.numbers[0] = Int.random(in: 0...self.symbols.count - 1)
                    self.numbers[1] = Int.random(in: 0...self.symbols.count - 1)
                    self.numbers[2] = Int.random(in: 0...self.symbols.count - 1)
                    
                    //print("Button Clicked!")
                    
                    //starting from 0
                    counter += 1 //onl till 6
                    
                    //winning logic
                    if self.numbers[0] == self.numbers[1] &&
                        self.numbers[1] == self.numbers[2]{
                        self.showingAlert = .success
                        counter = 0 //reset counter to 0 so we can start all over again
                    }
                    
                    if counter > 5{ //becuz counter starts from 0
                        self.showingAlert = .failure
                        counter = 0
                    }
                        
                }, label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("color")) //older versoin
                        .overlay(
                            Text("Spin")
                                .fontWeight(.black)
                                .font(.title3)
                                .foregroundStyle(.black)
                        )
                        .frame(width: 200, height: 40, alignment: .center)
                        .shadow(color: Color.gray, radius: 1, y: 4)
                })
            }
            .alert(item: $showingAlert){
                alert -> Alert in //closure line
                switch alert{
                case .success:
                    return Alert(title: Text("Yahhh!, you won!"), message:
                                    Text("You won the game"), dismissButton: .cancel())
                    
                case .failure:
                    return Alert(title: Text("Oops!, you lost!"), message:
                                    Text("You lost the game, Try Again!"), dismissButton: .cancel())
                    
                
                default:
                    break //this will create a warning(no pb)
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
