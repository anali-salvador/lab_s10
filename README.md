# Laboratorio S10 - App móvil estilo Netflix en Flutter

En este laboratorio hice el diseño de una app parecida a Netflix para celular. Es solo diseño, no tiene funcionalidad real.
Tiene una pantalla principal con un banner, pósters de películas y series, una sección de "Continuar viendo", y además una pantalla de detalle y otra de "Mi lista".

## Lo que usé

- ListView (vertical y horizontal)
- ListTile
- Cards
- Listas y mapas (`List<Map<String, String>>`) para los datos
- Rutas nombradas (`/`, `/detalle`, `/mi-lista`)
- Tema global oscuro con el rojo de Netflix
- 3 tipos de letra con google_fonts: Bebas Neue, Montserrat y Roboto
- Imágenes locales (`assets/images`) y de la nube (pósters de TMDB)

## Cómo ejecutarlo

```
flutter pub get
flutter run -d chrome
```

En Chrome la app se ve dentro de un marco de celular.
