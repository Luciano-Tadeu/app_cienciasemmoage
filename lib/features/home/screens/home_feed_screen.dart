import 'package:app_cienciasemmoage/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:app_cienciasemmoage/features/home/screens/home_white_card.dart';
import 'package:app_cienciasemmoage/features/home/screens/home_new_card.dart';
import 'package:app_cienciasemmoage/models/video.dart';
import 'package:app_cienciasemmoage/features/video_feed/widgets/youtube_service.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  final YoutubeService _youtubeService = YoutubeService();
  
  // O espião que vigia a rolagem da tela
  final ScrollController _scrollController = ScrollController();
  
  // Nossas variáveis de controle de estado
  List<Video> _videos = [];
  bool _carregandoInicial = true;
  bool _carregandoMais = false;

  @override
  void initState() {
    super.initState();
    _buscarVideosIniciais();
    
    // Grudamos o espião no controlador de rolagem
    _scrollController.addListener(_aoRolarATela);
  }

  @override
  void dispose() {
    // Sempre limpe o controlador ao sair da tela para não vazar memória
    _scrollController.dispose();
    super.dispose();
  }

  // Função disparada toda vez que o usuário arrasta o dedo
  void _aoRolarATela() {
    // Se ele rolou até o final (com uma margem de 100 pixels) e não estamos já carregando algo...
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      if (!_carregandoMais) {
        _buscarMaisVideos();
      }
    }
  }

  Future<void> _buscarVideosIniciais() async {
    List<String> ids = await _youtubeService.listarVideos();
    List<Video> videosCompletos = [];
    
    for (String id in ids) {
      Video? videoRico = await _youtubeService.buscarVideo(id);
      if (videoRico != null) videosCompletos.add(videoRico);
    }

    setState(() {
      _videos = videosCompletos;
      _carregandoInicial = false;
    });
  }

Future<void> _buscarMaisVideos() async {
    setState(() => _carregandoMais = true);

    // 1. Pede para o serviço buscar a próxima página (passando true)
    List<String> novosIds = await _youtubeService.listarVideos(carregarMais: true);
    
    // Se voltar vazio, significa que a playlist chegou no fim
    if (novosIds.isEmpty) {
      setState(() => _carregandoMais = false);
      return; 
    }

    List<Video> novosVideosRicos = [];
    
    // 2. Busca os detalhes de cada vídeo novo
    for (String id in novosIds) {
      Video? videoRico = await _youtubeService.buscarVideo(id);
      if (videoRico != null) novosVideosRicos.add(videoRico);
    }

    // 3. Atualiza a tela juntando as listas
    setState(() {
      // O .addAll() é mágico! Ele pega os vídeos que já estão na tela 
      // e gruda os vídeos novos no final da lista.
      _videos.addAll(novosVideosRicos); 
      _carregandoMais = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_carregandoInicial) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.secondary),
      );
    }

    if (_videos.isEmpty) {
      return const Center(
        child: Text("Nenhum vídeo encontrado.", style: TextStyle(color: Colors.white)),
      );
    }

    return ListView.builder(
      controller: _scrollController, // Vinculamos o ListView ao nosso espião
      padding: const EdgeInsets.only(top: 220, left: 16, right: 16, bottom: 100),
      
      // Somamos +1 no tamanho da lista se estivermos carregando mais, 
      // para mostrar a bolinha de loading lá no final
      itemCount: _videos.length + (_carregandoMais ? 1 : 0),
      
      itemBuilder: (context, index) {
        // Se o index for igual ao tamanho da lista, é hora de desenhar o loading extra
        if (index == _videos.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Center(
              child: CircularProgressIndicator(color: AppColors.secondary),
            ),
          );
        }

        final video = _videos[index];

        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: HomeNewCard(
              title: video.titulo,
              section: 'Lançamento',
              time: '5 min',
              imageUrl: video.thumb,
            ),
          );
        } 
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: HomeWhiteCard(
            title: video.titulo,
            desc: "Ver mais...", 
            section: video.tags.isNotEmpty ? video.tags[0] : "Ciência",
            time: "5 min",
          ),
        );
      },
    );
  }
}