import SwiftUI
import Kingfisher

// Item del listado de personajes.
struct CharacterRowView: View {
    
    var character: Character
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            KFImage(URL(string: character.image))
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .cornerRadius(10)
                .clipped()
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .padding(2)
            }
            .frame(maxWidth: .infinity)
            .background(.black)
            .opacity(0.7)
        }
        .cornerRadius(10)
        .clipped()
    }
}

struct CharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRowView(character:
                            Character(id: 1,
                                      name: "Rick",
                                      status: "Status",
                                      species: "Especies",
                                      type: "tipo",
                                      gender: "male",
                                      origin: ResumeLocation(name: "Location", url: ""),
                                      location: ResumeLocation(name: "resume", url: "sad"),
                                      image: "",
                                      episode: []))
    }
}
