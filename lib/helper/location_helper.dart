const MAPBOX_API_KEY = 'pk.eyJ1IjoiZ2FiYW9hbGIiLCJhIjoiY2t0MjVheWpxMGs1eTJubngxbWw5azhoZyJ9.OFePsKmBnWUJlwJ0AZP-lw';

class LocationHelper {
  static String generatePreview({required double latitude,required double longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$MAPBOX_API_KEY';
  }
}