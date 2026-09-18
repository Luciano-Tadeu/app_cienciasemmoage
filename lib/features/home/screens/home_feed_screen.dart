import 'package:app_cienciasemmoage/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:app_cienciasemmoage/features/home/screens/home_white_card.dart';
import 'package:app_cienciasemmoage/features/home/screens/home_new_card.dart';
import 'package:app_cienciasemmoage/models/video.dart';
import 'package:app_cienciasemmoage/features/video_feed/widgets/youtube_service.dart';

class HomeFeedScreen extends StatefulWidget {
  final void Function(String) playNewVideo;

  const HomeFeedScreen({super.key, required this.playNewVideo});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  final YoutubeService _youtubeService = YoutubeService();
  
  final ScrollController _scrollController = ScrollController();
  
  List<Video> _videos = [];
  bool _carregandoInicial = true;
  bool _carregandoMais = false;

  @override
  void initState() {
    super.initState();
    _buscarVideosIniciais();
    
    _scrollController.addListener(_aoRolarATela);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _aoRolarATela() {
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

    if (!mounted) return;

    setState(() {
      _videos = videosCompletos;
      _carregandoInicial = false;
    });
  }

Future<void> _buscarMaisVideos() async {
    if (!mounted) return;

    setState(() => _carregandoMais = true);

    List<String> novosIds = await _youtubeService.listarVideos(carregarMais: true);

    if (!mounted) return;
    
    if (novosIds.isEmpty) {
      setState(() => _carregandoMais = false);
      return; 
    }

    List<Video> novosVideosRicos = [];
    
    for (String id in novosIds) {
      Video? videoRico = await _youtubeService.buscarVideo(id);
      if (videoRico != null) novosVideosRicos.add(videoRico);
    }

    if (!mounted) return;

    setState(() { 
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
        child: Text("Nenhum vídeo encontrado.", style: TextStyle(color: Colors.black)),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 220, left: 16, right: 16, bottom: 100),
      
      itemCount: _videos.length + (_carregandoMais ? 1 : 0),
      
      itemBuilder: (context, index) {
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
              time: video.tempo,
              imageUrl: video.thumb,
              videoUrl: video.id,
              playNewVideo: widget.playNewVideo,
            ),
          );
        } 
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: HomeWhiteCard(
            title: video.titulo,
            videoUrl: video.id,
            desc: video.descricao.compareTo("") == 0? "Ver mais..." : video.descricao, 
            section: video.tags.isNotEmpty ? video.tags[0] : "Ciência",
            time: video.tempo,
            playNewVideo: widget.playNewVideo,
          ),
        );
      },
    );
  }
}