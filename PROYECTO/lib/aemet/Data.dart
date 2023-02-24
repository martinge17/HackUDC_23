class Data {
  String? nombre;
  int? probabilidadprec;
  String? estado_cielo;
  int? vel_viento;
  int? humedad_max;
  int? humedad_min;
  int? temp_max;
  int? temp_min;


  Data(this.nombre,
      this.probabilidadprec,
      this.estado_cielo,
      this.vel_viento,
      this.humedad_max,
      this.humedad_min,
      this.temp_max,
      this.temp_min);

  @override
  String toString() {
    return 'Data{nombre: $nombre, probabilidadprec: $probabilidadprec, estado_cielo: $estado_cielo, vel_viento: $vel_viento, humedad_max: $humedad_max, humedad_min: $humedad_min, temp_max: $temp_max, temp_min: $temp_min}';
  }
}