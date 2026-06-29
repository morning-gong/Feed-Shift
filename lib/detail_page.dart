import 'dart:ui';

import 'package:flutter/material.dart';

import 'data/mock/feed_profiles.dart';
import 'recommendation_page.dart';
import 'theme/app_theme.dart';
import 'theme/feed_visual_theme.dart';
import 'widgets/glass_card.dart';

class DetailPage extends StatelessWidget {
  final FeedState state;
  final FeedVisualTheme palette;
  final String sceneTitle;

  const DetailPage({
    super.key,
    required this.state,
    required this.palette,
    required this.sceneTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: _DetailWallpaper(palette: palette)),
          SafeArea(
            child: Column(
              children: [
                _DetailTopBar(state: state, palette: palette),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _FieldHero(state: state, palette: palette),
                        const SizedBox(height: 16),
                        _NotesPanel(state: state, palette: palette),
                        const SizedBox(height: 16),
                        _ExplorePanel(
                          state: state,
                          palette: palette,
                          sceneTitle: sceneTitle,
                        ),
                        const SizedBox(height: 26),
                        _FooterNote(palette: palette),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailTopBar extends StatelessWidget {
  final FeedState state;
  final FeedVisualTheme palette;

  const _DetailTopBar({required this.state, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 20, 6),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white.withValues(alpha: FsAlpha.icon),
              size: 20,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.tag, style: FsText.sectionHeader(Colors.white)),
                const SizedBox(height: 2),
                Text(
                  '最近注意力的一张卡片',
                  style: FsText.label(Colors.white).copyWith(
                    color: palette.mutedTextColor.withValues(alpha: 0.64),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldHero extends StatelessWidget {
  final FeedState state;
  final FeedVisualTheme palette;

  const _FieldHero({required this.state, required this.palette});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      palette: palette,
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
      isPrimary: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w700,
              height: 1.08,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            state.description,
            style: FsText.body(Colors.white).copyWith(
              color: Colors.white.withValues(alpha: 0.76),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 28),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: palette.baseColor.withValues(alpha: 0.34),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: palette.borderColor.withValues(alpha: 0.26),
              ),
            ),
            child: Text(
              state.hint,
              style: FsText.caption(Colors.white).copyWith(
                color: palette.mutedTextColor.withValues(alpha: 0.72),
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotesPanel extends StatelessWidget {
  final FeedState state;
  final FeedVisualTheme palette;

  const _NotesPanel({required this.state, required this.palette});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      palette: palette,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(
            title: '为什么是这张卡片',
            subtitle: '来自最近看到的内容',
            palette: palette,
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < state.reasons.length; i++)
            Padding(
              padding: EdgeInsets.only(
                bottom: i == state.reasons.length - 1 ? 0 : 12,
              ),
              child: _ReasonRow(text: state.reasons[i], palette: palette),
            ),
        ],
      ),
    );
  }
}

class _ReasonRow extends StatelessWidget {
  final String text;
  final FeedVisualTheme palette;

  const _ReasonRow({required this.text, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: palette.accentColor.withValues(alpha: 0.72),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: FsText.bodySmall(Colors.white))),
      ],
    );
  }
}

class _ExplorePanel extends StatelessWidget {
  final FeedState state;
  final FeedVisualTheme palette;
  final String sceneTitle;

  const _ExplorePanel({
    required this.state,
    required this.palette,
    required this.sceneTitle,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      palette: palette,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(
            title: '可以做什么',
            subtitle: '选一个具体动作，不再只换概念',
            palette: palette,
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 9,
            runSpacing: 9,
            children: state.explore
                .map(
                  (item) => _ExploreChip(
                    label: item.label,
                    palette: palette,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecommendationPage(
                          item: item,
                          palette: palette,
                          sceneTitle: sceneTitle,
                          backgroundImage: palette.backgroundImage,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ExploreChip extends StatefulWidget {
  final String label;
  final FeedVisualTheme palette;
  final VoidCallback onTap;

  const _ExploreChip({
    required this.label,
    required this.palette,
    required this.onTap,
  });

  @override
  State<_ExploreChip> createState() => _ExploreChipState();
}

class _ExploreChipState extends State<_ExploreChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 160),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.94,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: widget.palette.accentColor.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(FsChip.radius),
            border: Border.all(
              color: widget.palette.borderColor.withValues(alpha: 0.34),
              width: FsGlass.borderWidth,
            ),
          ),
          child: Text(widget.label, style: FsText.chip(Colors.white)),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String title;
  final String subtitle;
  final FeedVisualTheme palette;

  const _SectionLabel({
    required this.title,
    required this.subtitle,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: FsText.cardHeader(Colors.white)),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: FsText.label(
            Colors.white,
          ).copyWith(color: palette.mutedTextColor.withValues(alpha: 0.62)),
        ),
      ],
    );
  }
}

class _FooterNote extends StatelessWidget {
  final FeedVisualTheme palette;

  const _FooterNote({required this.palette});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '先看见，再换一个方向。',
        style: FsText.footer(
          Colors.white,
        ).copyWith(color: palette.mutedTextColor.withValues(alpha: 0.48)),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _DetailWallpaper extends StatelessWidget {
  final FeedVisualTheme palette;

  const _DetailWallpaper({required this.palette});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(palette.backgroundImage, fit: BoxFit.cover),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.6, sigmaY: 0.6),
          child: const SizedBox.expand(),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.42, 1.0],
              colors: [
                Colors.black.withValues(alpha: 0.36),
                palette.baseColor.withValues(alpha: 0.42),
                palette.surfaceColor.withValues(alpha: 0.88),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
