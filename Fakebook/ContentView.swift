//
//  ContentView.swift
//  Fakebook
//
//  Created by gsm10 on 2021/11/05.
//

import SwiftUI

struct FBPostModel: Hashable {
    let name: String
    let post: String
    let imageName: String
}

struct ContentView: View {
    
    @Binding var text: String
    
    let stories = ["Image1", "Image2", "Image3"]
    
    let posts: [FBPostModel] = [
        FBPostModel(name: "Mark Zuckerberg", post: "Hey guys I made this cool website called the facebook to see if Im cool or not!", imageName: "person1"),
        FBPostModel(name: "Jeff Bezos", post: "You'll all see once I take over the world with Amzon.", imageName: "person2"),
        FBPostModel(name: "Bill Gates", post: "Who cares - I made windows!", imageName: "person3")
    ]
    
    let facebookBlue = UIColor(red: 23/255.0,
                               green: 120/255.0,
                               blue: 242/255.0,
                               alpha: 1)
    
    var body: some View {
        VStack {
            HStack{
                Text("facebook")
                    .font(.system(size: 48, weight: .bold, design: .default))
                    .foregroundColor(Color(facebookBlue))
                Spacer()
                
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 45, height: 45, alignment: .center)
                    .foregroundColor(Color(.secondaryLabel))
            }
            .padding()
            
            TextField("Search...", text: $text)
                .padding(7)
                .background(Color(.systemGray5))
                .cornerRadius(13)
                .padding(.horizontal, 15)
            
            ZStack{
                Color(.secondarySystemBackground)
                
                ScrollView(.vertical) {
                    VStack {
                        StoriesView(stories: stories)
                        ForEach(posts, id: \.self) { model in
                            FBPost(model: model)
                            Spacer()
                        }
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct StoriesView: View {
    
    let stories: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 3) {
                ForEach(stories, id: \.self){ name in
                    Image(name)
                        .resizable()
                        .aspectRatio( contentMode: .fill)
                        .frame(width: 140, height: 200, alignment: .center)
                        .background(Color.red)
                        .clipped()
                }
            }
            .padding()
        }
        
    }
}

struct FBPost: View {
    
    @State var isLiked: Bool = false
    
    let model: FBPostModel
    
    var body: some View {
        VStack {
            HStack {
                Image(model.imageName)
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                    .aspectRatio( contentMode: .fill)
                    .cornerRadius(25)
                VStack {
                    HStack{
                        Text(model.name)
                            .foregroundColor(Color.blue)
                            .font(.system(size: 18, weight: .semibold, design: .default))
                        Spacer()
                    }
                    HStack{
                        Text("12 minutes ago")
                        Spacer()
                    }
                }
                Spacer()
            }
            Spacer()
            
            HStack {
                Text(model.post)
                    .font(.system(size: 24, weight: .regular, design: .default))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    isLiked.toggle()
                }, label: {
                    Text(isLiked ? "Liked" : "Like")
                })
                
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text("Comment")
                })
                
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text("Share")
                })
            }
            .padding()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(7)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(text: .constant(""))
    }
}
