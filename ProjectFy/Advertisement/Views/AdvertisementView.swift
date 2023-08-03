//
//  AdvertisementView.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import SwiftUI

struct AdvertisementView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                UserInfo()
                
                Image(systemName: "ellipsis")
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 10)
                    .padding(.leading, 27)
            }
            
            Text("Game de aventura")
                .font(.title)
                .padding(.top, 21)
            
            HStack(spacing: 27) {
                Text("20h semanais")
                Text("Em andamento")
            }
            .removePadding()
            .padding(.top, 7)
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incid idunt ut labore et dolore magna aliqua.")
                .removePadding()
                .padding(.top, 5)
            
            let teste = ["1", "2", "3",]
            
            let columns = Array(
                repeating: GridItem(.adaptive(minimum: 77), alignment: .leading),
                count: 3
            )
            
            DynamicVGrid(columnsCount: 3) {
                Tag(text: "Level Design")
                
                Tag(text: "Game Design")
                Tag(text: "Design")
            }
//            LazyVGrid(columns: columns) {
//                ForEach(teste, id: \.self) { teste in
//                    Tag(text: "Level Design")
//                    Tag(text: "Game Design")
//                    Tag(text: "Design")
//
//                }
//            }.background(Color.gray)
            
            
        }
    }
}

struct TagGrid: View {
    let numberOfColumns: Int
    let tags: [String]
    
    var body: some View {
        LazyVGrid(columns: getColumns()) {
            
        }
        
//        let _ = dump(views)
//        Mirror(reflecting: view).ch
        
//        view.child
//        let teste = TupleView((view))
//        let _ = print(teste)
//        teste.
//        dump(teste)
        Text("aaa")
    }
    
    private func getColumns() -> [GridItem] {
        var columns: [GridItem] = []
        
        tags.forEach { tag in
            columns.append(
                GridItem(.fixed(tag.width(using: .systemFont(ofSize: 17))))
            )
        }
        
        return columns
    }
}

extension String {
    func width(using font: UIFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: attributes)
        
        return size.width
    }
}

struct Tag: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.blue)
                    .frame(minWidth: 77)
                    .padding(.all, -5)
            }
            .padding(.all, 5)
    }
}

struct UserInfo: View {
    var body: some View {
        Circle()
            .frame(width: 67, height: 67)
        
        VStack {
            HStack(spacing: 5) {
                Text("Jade Arruda")
                Text("@arrudajade")
            }
            
            HStack(spacing: 9) {
                Text("UI/UX Designer")
                
                Circle()
                    .frame(width: 4, height: 4)
                
                Text("Iniciante")
            }
        }
    }
}

extension View {
    func removePadding() -> some View {
        self.padding(.top, -12)
    }
}

extension Array {
    init<Content: View>(content: Content) {
        let children = Mirror(reflecting: content).children
        
        guard let views = children.map(\.value) as? Self else {
            self = []
            return
        }
        
        self = views
    }
    
//    init(from tuple: ()) {
////        Array
//    }
}

struct AdvertisementView_Previews: PreviewProvider {
    static var previews: some View {
        AdvertisementView()
    }
}
