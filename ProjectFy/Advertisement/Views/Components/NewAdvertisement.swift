//
//  NewAdvertisement.swift
//  ProjectFy
//
//  Created by Iago Ramos on 06/08/23.
//

import Foundation
import SwiftUI

extension AdvertisementsView {
    struct NewAdvertisement: View {
        @Environment(\.dismiss) var dismiss
        
        @EnvironmentObject var advertisementsViewModel: AdvertisementsViewModel
        @EnvironmentObject var userViewModel: UserViewModel
        
        @State var advertisement: Advertisement
        @State var presentBackAlert: Bool = false
        
        let mytoken =
        """
        dYoLEoNX8UJ4i5hqg01zfe:APA91bExgdfwk2osT8ZBD3LMzjU5qT2
        COFs8aApolcX8th50uht8jg39hHZLZPK5aDYe52LA2-OUYgC5cc9YeBj
        Ah8PMHvirVO8Lp4tDzgnYEMbnr4lC0ZKFusOHUJemEhDZoKFTEAr9
        """
        
//        let sender = PushNotificationSender()
        
        var viewModel: AdvertisementsViewModel
        @Binding var popToRoot: Bool
        var editingID: String?
        
        init(owner: User, viewModel: AdvertisementsViewModel, popToRoot: Binding<Bool>, editingID: String?) {
            self._advertisement = State(initialValue: Advertisement(owner: owner))
            self.viewModel = viewModel
            self._popToRoot = popToRoot
            self.editingID = editingID
        }
        
        var body: some View {
            ScrollView {
                VStack(alignment: .leading) {

                    TextField("Add 10 tags to your project...", text: $advertisement.tags)
                        .font(Font.body)
                        .foregroundColor(.editAdvertisementText)
                        .padding(.top, 25)
                    
                    TextField("Name your project...", text: $advertisement.title)
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.editAdvertisementText)
                        .padding(.top, 44)
                    
                    TextField("Describe your project in 1000 characters or less...", text: $advertisement.description)
                        .font(Font.body)
                        .foregroundColor(.editAdvertisementText)
                        .padding(.top, 54)
                    
                    DropDownButton(
                        title: "Project status", textColor: .textColorBlue,
                        selection: $advertisement.ongoing,
                        menuItems: [
                            MenuItem(name: "Not started", tag: false),
                            MenuItem(name: "In progress", tag: true)
                        ]
                    )
                    .padding(.top, 20)
                    
                    Button("aperte aqui") {
//                        sender.sendPushNotification(to: "\(mytoken)", title: "Notification title", body: "Notification body")
                    }
                    
                    Spacer()
                }
                .padding([.horizontal, .top], 16)
            }
            
            .onAppear {
                guard let editingID = editingID else { return }
                guard let advertisement = viewModel.getAdvertisement(with: editingID) else { return }
                
                self.advertisement = advertisement
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentBackAlert = true
                    } label: {
                        HStack {
                            Text("X")
                                .font(Font.title3.bold())
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        Positions(
                            advertisement: $advertisement,
                            popToRoot: $popToRoot,
                            isEditing: editingID != nil
                        )
                            .environmentObject(advertisementsViewModel)
                    } label: {
                        Text("Next")
                    }.disabled(!(cantNext()))

                    .simultaneousGesture(TapGesture().onEnded({ _ in
                        Haptics.shared.selection()
                    }))
                }
            }
            
            .alert("Do you really want to delete this project announcement?", isPresented: $presentBackAlert) {
                Button(role: .cancel) {
                    presentBackAlert = false
                } label: {
                    Text("Cancel")
                }

                Button(role: .destructive) {
                    dismiss()
                } label: {
                    Text("Delete")
                }
            } message: {
                Text("This project announcement will be deleted permanentely")
            }

        }
        
        private func cantNext() -> Bool {
                // Verificar se os campos relevantes estão preenchidos
                return !advertisement.tags.isEmpty
                    && !advertisement.title.isEmpty
                    && !advertisement.description.isEmpty
            }
    }
    
    private struct Positions: View {
        @EnvironmentObject var viewModel: AdvertisementsViewModel
        
        @Binding var advertisement: Advertisement
        @Binding var popToRoot: Bool
        
        let isEditing: Bool
        
        var body: some View {
            ScrollView {
                VStack {
                    Text("Create project vacancies")
                        .font(Font.title.bold())
                    
                    ForEach(0..<advertisement.positions.count, id: \.self) { index in
                        Position(position: $advertisement.positions[index])
                    }
                    
                    HStack {
                        Button {
                            newPosition()
                            Haptics.shared.selection()
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color.textColorBlue)
                                
                                Image(systemName: "plus")
                                    .font(Font.title2.bold())
                                    .foregroundColor(.white)
                            }
                            .frame(width: 54, height: 54)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
            .onAppear {
                if advertisement.positions.isEmpty {
                    newPosition()
                }
            }
            .toolbar {
                Button {
                    if isEditing {
                        viewModel.editAdvertisement(advertisement)
                        popToRoot.toggle()
        
                        Haptics.shared.notification(.success)
                        return
                    }
                    
                    viewModel.createAdvertisement(advertisement)
                    
                    Haptics.shared.notification(.success)
                    popToRoot.toggle()
                } label: {
                    Text(isEditing ? "Edit" : "Share")
                }.disabled(!cantShare())
            }
        }
        
        private func newPosition() {
            advertisement.positions.append(
                ProjectGroup.Position(
                    id: UUID().uuidString,
                    title: "",
                    description: "",
                    vacancies: 1
                )
            )
        }

        private func cantShare() -> Bool {
            return !advertisement.positions.isEmpty &&
            advertisement.positions.allSatisfy { !$0.title.isEmpty }
        }
    }
    
    private struct Position: View {
        @Binding var position: ProjectGroup.Position
        
        var body: some View {
            RoundedRectangleContent(cornerRadius: 20, fillColor: Color.backgroundRole) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Project role name")
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button {
                            print("EXCLUIR VAGA")
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(.white)
                        }
                    }
                    TextField("", text: $position.title)
                        .placeholder(when: position.title.isEmpty, placeholder: {
                            Text("Ex: UI/UX Design, Software Engeneer...")
                                .foregroundColor(.placeholderColor)
                        }).foregroundColor(.white)
                    
                    Divider()
                    
                    Text("Project role descripition (optional)")
                        .foregroundColor(.white)
                    TextField("", text: $position.description)
                        .placeholder(when: position.description.isEmpty, placeholder: {
                            Text("Describe what the person entering this role will do on the project...")
                                .foregroundColor(.placeholderColor)
                        }).foregroundColor(.white)

                    Divider()
                    
                    HStack(spacing: 15) {
                        Text("Quantity")
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        VacancyButton(position: $position, isPlusButton: false)
                        Text("\(position.vacancies)")
                            .foregroundColor(.white)
                        VacancyButton(position: $position, isPlusButton: true)
                    }
                }
                .padding(.all, 16)
            }
        }
    }
    
    private struct VacancyButton: View {
        @Binding var position: ProjectGroup.Position
        let isPlusButton: Bool
        
        var body: some View {
            Button {
                position.vacancies += isPlusButton ? 1 : -1
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.textColorBlue)
                    
                    Image(systemName: isPlusButton ? "plus" : "minus")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                }
            }
            .disabled(!isPlusButton && position.vacancies < 2)
            .frame(width: 19, height: 19)
        }
    }
}
