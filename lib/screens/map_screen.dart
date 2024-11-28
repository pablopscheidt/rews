import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Marker> _markers = Set<Marker>();
  List<LatLng> _currentPolygonPoints = [];  // Lista de pontos para o pol�gono atual
  bool _isAddingPolygon = false; // Flag para indicar se estamos no modo de adi��o de pol�gono
  int _riskLevel = 0; // N�vel de risco (0 = Baixo, 1 = M�dio, 2 = Alto)
  LatLng _polygonCenter = LatLng(0, 0);  // Centro do pol�gono
  bool _isFirstClick = false; // Flag para verificar o primeiro clique no mapa

  // Fun��o para adicionar um ponto ao pol�gono
  void _addPointToPolygon(LatLng position) {
    if (_isAddingPolygon && !_isFirstClick) {
      setState(() {
        _isFirstClick = true; // Marca que o primeiro clique aconteceu
      });
    } else if (_isAddingPolygon && _isFirstClick) {
      setState(() {
        // Evita adicionar pontos duplicados
        if (!_currentPolygonPoints.contains(position)) {
          _currentPolygonPoints.add(position);
          _addMarker(position);

          // Quando atingimos 3 pontos, finaliza o pol�gono
          if (_currentPolygonPoints.length == 3) {
            _finalizePolygon();
          }
        }
      });
    }
  }

  // Adiciona um marcador no mapa
  void _addMarker(LatLng position) {
    Marker newMarker = Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      infoWindow: InfoWindow(
        title: "Ponto do Pol�gono",
        snippet: "Latitude: ${position.latitude}, Longitude: ${position.longitude}",
      ),
    );

    setState(() {
      _markers.add(newMarker);
    });
  }

  // Finaliza o pol�gono ao adicionar 3 pontos
  void _finalizePolygon() {
    // Calcula o centro do pol�gono
    _polygonCenter = _calculateCenterOfPolygon(_currentPolygonPoints);

    // Adiciona o pol�gono com a cor baseada no n�vel de risco
    setState(() {
      Color polygonColor;
      switch (_riskLevel) {
        case 0:
          polygonColor = Colors.green.withOpacity(0.5); // Baixo risco (Verde)
          break;
        case 1:
          polygonColor = Colors.yellow.withOpacity(0.5); // M�dio risco (Amarelo)
          break;
        case 2:
          polygonColor = Colors.red.withOpacity(0.5); // Alto risco (Vermelho)
          break;
        default:
          polygonColor = Colors.green.withOpacity(0.5); // Padr�o (Verde)
      }

      _polygons.add(Polygon(
        polygonId: PolygonId(_currentPolygonPoints.toString()),
        points: _currentPolygonPoints,
        strokeColor: Colors.blue,
        strokeWidth: 2,
        fillColor: polygonColor,
      ));

      // Limpa os pontos para come�ar um novo pol�gono
      _currentPolygonPoints = [];
      _isAddingPolygon = false;  // Desativa o modo de adi��o de pol�gono
      _isFirstClick = false; // Reseta a flag de clique
    });
  }

  // Fun��o para calcular o centro do pol�gono
  LatLng _calculateCenterOfPolygon(List<LatLng> points) {
    double latSum = 0;
    double lngSum = 0;

    for (var point in points) {
      latSum += point.latitude;
      lngSum += point.longitude;
    }

    return LatLng(latSum / points.length, lngSum / points.length);
  }

  // Fun��o para exibir a legenda de cores
  Widget _buildLegend() {
    return Positioned(
      top: 20,
      left: 20,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildColorLegendBox(Colors.green, 'Baixo risco (Verde)'),
            SizedBox(height: 4),
            _buildColorLegendBox(Colors.yellow, 'Risco m�dio (Amarelo)'),
            SizedBox(height: 4),
            _buildColorLegendBox(Colors.red, 'Alto risco (Vermelho)'),
          ],
        ),
      ),
    );
  }

  // Fun��o para criar um quadrado de cor e a legenda
  Widget _buildColorLegendBox(Color color, String description) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        SizedBox(width: 8),
        Text(description, style: TextStyle(fontSize: 14)),
      ],
    );
  }

  // Fun��o para selecionar o n�vel de risco
  void _selectRiskLevel(int level) {
    setState(() {
      _riskLevel = level;
      _isAddingPolygon = true; // Ativa o modo de adicionar pol�gono
      _isFirstClick = false;  // Reseta o primeiro clique
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa de Riscos de Alagamento"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                },
                onTap: (LatLng position) {
                // S� adiciona pontos se o modo de adicionar pol�gono estiver ativado
                if (_isAddingPolygon) {
                    _addPointToPolygon(position);
                }
                },
                initialCameraPosition: CameraPosition(
                target: LatLng(-27.21417, -49.64306),  // Coordenadas de Rio do Sul
                zoom: 12,
                ),
                polygons: _polygons,
                markers: _markers,
            ),
          // Mostrar a legenda de cores
          _buildLegend(),
          // Bot�es para selecionar o grau de risco
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (!_isAddingPolygon) _selectRiskLevel(0); // Baixo risco
                  },
                  child: Text("Baixo Risco"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (!_isAddingPolygon) _selectRiskLevel(1); // Risco m�dio
                  },
                  child: Text("Risco M�dio"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (!_isAddingPolygon) _selectRiskLevel(2); // Alto risco
                  },
                  child: Text("Alto Risco"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
