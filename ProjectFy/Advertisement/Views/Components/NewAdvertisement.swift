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
        let owner: User
        var viewModel: AdvertisementsViewModel
        
        @FocusState var isTextFieldFocused: Bool
        @State var advertisement: Advertisement
        @Binding var dismiss: Bool
        @Binding var updateAdvertisements: Bool
        @State private var height: CGFloat?
        let minHeight: CGFloat = 30
        
        @State var presentBackAlert: Bool = false
        let isEditing: Bool
        
        init(owner: User, viewModel: AdvertisementsViewModel,
             dismiss: Binding<Bool>,
             updateAdvertisements: Binding<Bool>, editingID: String?) {
            self.owner = owner
            self.viewModel = viewModel
            self._dismiss = dismiss
            self._updateAdvertisements = updateAdvertisements
            
            if let editingID = editingID, let advertisement = viewModel.getAdvertisement(with: editingID) {
                self._advertisement = State(initialValue: advertisement)
                self.isEditing = true
                return
            }
            
            self._advertisement = State(initialValue: Advertisement(owner: owner))
            self.isEditing = false
        }
        
        var body: some View {
            NavigationView {
                ScrollView {
                    Divider()
                    
                    VStack(alignment: .leading) {
                        UserInfo(user: owner, size: 49, nameColor: .backgroundRole)
                            .padding(.top, -10)
                        
                        CustomWrappedText(text: $advertisement.title,
                                          placeholder: "Name your project...",
                                          textFont: UIFont.systemFont(ofSize: 32, weight: .bold),
                                          textcolor: UIColor(named: "backgroundRole") ?? .black)
                        .font(Font.largeTitle.bold())
                        .foregroundColor(advertisement.title.isEmpty ? .editAdvertisementText : .backgroundRole)
                        .padding(.top, 25)

                        CustomWrappedText(text: $advertisement.description,
                            placeholder: "Use 1000 characteres or less to describe an project overview or specify conditions and requirements.",
                                          textFont: UIFont.preferredFont(forTextStyle: .body),
                                          textcolor: UIColor(named: "backgroundRole") ?? .black)
                        .font(.body)
                        .foregroundColor(advertisement.description.isEmpty ? .editAdvertisementText : .backgroundRole)
                        .padding(.top, 48)
                        
                        CustomWrappedText(text: $advertisement.tags,
                                          placeholder: "Add 10 tags that are related to your project to help interested people find it...",
                                          textFont: UIFont.preferredFont(forTextStyle: .body),
                                          textcolor: UIColor(named: "backgroundRole") ?? .black)
                        .font(.body)
                        .foregroundColor(advertisement.tags.isEmpty ? .editAdvertisementText : .backgroundRole)
                        .padding(.top, 48)
                        
                        Spacer()
                    }
                    .padding([.horizontal, .top], 16)
                }
                .navigationBarBackButtonHidden()
                .navigationTitle("\(isEditing ? "Edit" : "Create") project")
                .navigationBarTitleDisplayMode(.inline)
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            presentBackAlert = true
                        } label: {
                            HStack {
                                Image(systemName: "xmark")
                                    .font(Font.system(size: 15, weight: .bold))
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            Positions(
                                owner: owner,
                                advertisement: $advertisement,
                                dismiss: $dismiss,
                                updateAdvertisements: $updateAdvertisements,
                                isEditing: isEditing
                            )
                        } label: {
                            Text("Next")
                        }
                        .disabled(!canContinue())
                        
                        .simultaneousGesture(TapGesture().onEnded({ _ in
                            Haptics.shared.selection()
                        }))
                    }
                }
            }
            
            .confirmationDialog("back", isPresented: $presentBackAlert) {
                Button(role: .destructive) {
                    presentBackAlert = false
                    dismiss.toggle()
                } label: {
                    Text("Delete draft")
                }
                
                Button(role: .cancel) {
                    presentBackAlert = false
                } label: {
                    Text("Cancel")
                }
            }
        }
        
        private func canContinue() -> Bool {
            return !advertisement.tags.isEmpty
            && !advertisement.title.isEmpty
            && !advertisement.description.isEmpty
        }
        
        private func textDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.height = max(textView.contentSize.height, minHeight)
            }
        }
    }
    
    private struct Positions: View {
        @EnvironmentObject var viewModel: AdvertisementsViewModel
        
        let owner: User
        @Binding var advertisement: Advertisement
        
        @Binding var dismiss: Bool
        @Binding var updateAdvertisements: Bool
        
        let isEditing: Bool
        
        var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    UserInfo(user: owner, size: 49, nameColor: .backgroundRole)
                        .padding(.bottom, 30)
                    
                    ForEach(0..<advertisement.positions.count, id: \.self) { index in
                        Position(advertisement: $advertisement, position: $advertisement.positions[index])
                    }
                    
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
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.top, 10)
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
                        Haptics.shared.notification(.success)
                        updateAdvertisements.toggle()
                        dismiss.toggle()
                        return
                    }
                    
                    viewModel.createAdvertisement(advertisement)
                    Haptics.shared.notification(.success)
                    updateAdvertisements.toggle()
                    dismiss.toggle()
                    
                } label: {
                    Text(isEditing ? "Edit" : "Share")
                }
                .disabled(!cantShare())
            }
        }
        
        private func newPosition() {
            let position = ProjectGroup.Position(
                id: UUID().uuidString,
                advertisementID: advertisement.id,
                title: "",
                description: "",
                vacancies: 1
            )
            
            advertisement.positions.insert(position, at: 0)
        }
        
        private func cantShare() -> Bool {
            return !advertisement.positions.isEmpty &&
            advertisement.positions.allSatisfy { !$0.title.isEmpty }
        }
    }
    
    private struct Position: View {
        @Binding var advertisement: Advertisement
        @Binding var position: ProjectGroup.Position
        
        var body: some View {
            RoundedRectangleContent(cornerRadius: 20, fillColor: Color.backgroundRole) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Role name")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button {
                            advertisement.positions.removeAll(where: { $0.id == position.id })
                        } label: {
                            Image("close")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                    TextField("", text: $position.title)
                        .placeholder(when: position.title.isEmpty, placeholder: {
                            Text("Ex: UI/UX Design, Software Engeneer...")
                                .foregroundColor(.placeholderColor)
                        }).font(.body)
                        .foregroundColor(.white)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.placeholderColor)
                    
                    Text("Role descripition \(Text("(optional)").foregroundColor(.placeholderColor).font(.body))")
                        .font(.headline)
                        .foregroundColor(.white)

                    CustomWrappedText(text: $position.description,
                                      placeholder: "Describe what the person entering this role will do on the project...",
                                      textFont: UIFont.preferredFont(forTextStyle: .body),
                                      textcolor: UIColor.white)
                    .font(.body)
                    .foregroundColor(position.description.isEmpty ? .placeholderColor : .white)
                
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.placeholderColor)
                    
                    HStack(spacing: 15) {
                        Text("Quantity")
                            .font(.headline)
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
        let maxVacancies: Int = 10
        
        var body: some View {
            Button {
                if isPlusButton {
                    if position.vacancies < maxVacancies {
                        position.vacancies += 1
                    }
                } else {
                    if position.vacancies > 0 {
                        position.vacancies -= 1
                    }
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.textColorBlue)
                        .opacity(!isPlusButton && position.vacancies == 1 ? 0.2 : 1)
                        .opacity(isPlusButton && position.vacancies == maxVacancies ? 0.2 : 1)
                    
                    Image(systemName: isPlusButton ? "plus" : "minus")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
            }
            .disabled(!isPlusButton && position.vacancies < 2)
            .frame(width: 28, height: 28)
        }
    }
}
