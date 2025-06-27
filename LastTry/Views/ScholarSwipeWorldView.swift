import SwiftUI
import MapKit

struct DownloadLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let city: String
    let country: String
}

struct ScholarSwipeWorldView: View {
    // Simulated download locations
    @State private var downloadLocations: [DownloadLocation] = [
        DownloadLocation(coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060), city: "New York", country: "USA"),
        DownloadLocation(coordinate: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278), city: "London", country: "UK"),
        DownloadLocation(coordinate: CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917), city: "Tokyo", country: "Japan"),
        DownloadLocation(coordinate: CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2090), city: "Delhi", country: "India"),
        DownloadLocation(coordinate: CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093), city: "Sydney", country: "Australia"),
        DownloadLocation(coordinate: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522), city: "Paris", country: "France"),
        DownloadLocation(coordinate: CLLocationCoordinate2D(latitude: -23.5505, longitude: -46.6333), city: "São Paulo", country: "Brazil"),
        DownloadLocation(coordinate: CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6173), city: "Moscow", country: "Russia"),
        DownloadLocation(coordinate: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), city: "Los Angeles", country: "USA"),
        DownloadLocation(coordinate: CLLocationCoordinate2D(latitude: 1.3521, longitude: 103.8198), city: "Singapore", country: "Singapore")
    ]
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 20, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 200)
    )
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: downloadLocations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack(spacing: 2) {
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.purple)
                            .shadow(radius: 4)
                        Text(location.city)
                            .font(.caption2.bold())
                            .foregroundColor(.white)
                            .padding(2)
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(6)
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    Text("Each pin represents a ScholarSwipe download from around the world! 🌍")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.purple.opacity(0.8))
                        .cornerRadius(14)
                        .padding(.top, 40)
                        .padding(.trailing, 16)
                        .multilineTextAlignment(.center)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ScholarSwipeWorldView()
} 